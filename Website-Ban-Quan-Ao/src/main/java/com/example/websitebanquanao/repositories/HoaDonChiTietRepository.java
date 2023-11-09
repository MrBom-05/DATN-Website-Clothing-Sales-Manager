package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDonChiTiet;
import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Repository
public interface HoaDonChiTietRepository extends JpaRepository<HoaDonChiTiet, UUID> {
    // admin
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.GioHangResponse(MIN(hdct.id), hdct.idSanPhamChiTiet.id, " +
            "hdct.idSanPhamChiTiet.maSanPham, hdct.idSanPhamChiTiet.idSanPham.ten,MIN(hdct.idSanPhamChiTiet.idMauSac.ten),MIN(hdct.idSanPhamChiTiet.idKichCo.ten), SUM(hdct.soLuong), min(hdct.gia)) " +
            "FROM HoaDonChiTiet hdct WHERE hdct.idHoaDon.id = :hoaDonId " +
            "GROUP BY hdct.idSanPhamChiTiet.id, hdct.idSanPhamChiTiet.maSanPham, hdct.idSanPhamChiTiet.idSanPham.ten, hdct.idSanPhamChiTiet.gia")
    List<GioHangResponse> findTotalQuantityByHoaDonId(@Param("hoaDonId") UUID hoaDonId);

    @Query("SELECT hdct FROM HoaDonChiTiet hdct WHERE hdct.idHoaDon.id = :idHoaDon AND hdct.idSanPhamChiTiet.id = :idSanPhamChiTiet")
    public HoaDonChiTiet findByHoaDonIdAndSanPhamChiTietId(UUID idHoaDon, UUID idSanPhamChiTiet);

    @Query("SELECT hdct.id FROM HoaDonChiTiet hdct WHERE hdct.idHoaDon.id = :idHoaDon")
    public UUID findIdHoaDonChiTietByIdHoaDon(UUID idHoaDon);

    // user
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse(sp.id, spct.id, spct.maSanPham, sp.ten, ms.id, ms.ten, kc.ten, hdct.soLuong, spct.soLuong, hdct.gia) FROM HoaDonChiTiet hdct JOIN hdct.idSanPhamChiTiet spct JOIN spct.idSanPham sp LEFT JOIN spct.idMauSac ms LEFT JOIN spct.idKichCo kc WHERE hdct.idHoaDon.id = :idHoaDon")
    public List<GioHangUserResponse> getListByIdHoaDon(@Param("idHoaDon") UUID idHoaDon);

    @Query("SELECT SUM(hdct.gia * hdct.soLuong) FROM HoaDonChiTiet hdct WHERE hdct.idHoaDon.id = :idHoaDon")
    public BigDecimal sumTongTienByIdHoaDon(@Param("idHoaDon") UUID idHoaDon);
}
