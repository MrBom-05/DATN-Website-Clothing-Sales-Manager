package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDonChiTiet;
import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface HoaDonChiTietRepository extends JpaRepository<HoaDonChiTiet, UUID> {
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.GioHangResponse(MIN(hdct.id), hdct.idSanPhamChiTiet.id, " +
            "hdct.idSanPhamChiTiet.maSanPham, hdct.idSanPhamChiTiet.idSanPham.ten, SUM(hdct.soLuong), hdct.idSanPhamChiTiet.gia) " +
            "FROM HoaDonChiTiet hdct WHERE hdct.idHoaDon.id = :hoaDonId " +
            "GROUP BY hdct.idSanPhamChiTiet.id, hdct.idSanPhamChiTiet.maSanPham, hdct.idSanPhamChiTiet.idSanPham.ten, hdct.idSanPhamChiTiet.gia")
    List<GioHangResponse> findTotalQuantityByHoaDonId(@Param("hoaDonId") UUID hoaDonId);

    @Query("SELECT hdct FROM HoaDonChiTiet hdct WHERE hdct.idHoaDon.id = :idHoaDon AND hdct.idSanPhamChiTiet.id = :idSanPhamChiTiet")
    public HoaDonChiTiet findByHoaDonIdAndSanPhamChiTietId(UUID idHoaDon, UUID idSanPhamChiTiet);
}
