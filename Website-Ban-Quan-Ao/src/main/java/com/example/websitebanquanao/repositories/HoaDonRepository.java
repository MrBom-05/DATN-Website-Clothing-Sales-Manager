package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.infrastructures.responses.HoaDonUserResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public interface HoaDonRepository extends JpaRepository<HoaDon, UUID> {

    // admin
    @Query("SELECT hd FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hdct.id = :idHoaDonChiTiet")
    HoaDon findHoaDonByHoaDonChiTietId(@Param("idHoaDonChiTiet") UUID idHoaDonChiTiet);

    @Query("SELECT hd FROM HoaDon hd where hd.trangThai = 0 order by hd.ma desc ")
    List<HoaDon> findAllHoaDon();

    // user
    @Query("select new com.example.websitebanquanao.infrastructures.responses.HoaDonUserResponse(hd.ma, hd.trangThai, hd.ngayTao, hd.ngayThanhToan, hd.nguoiNhan, hd.diaChi, hd.xaPhuong, hd.quanHuyen, hd.tinhThanhPho, hd.email, hd.soDienThoai, hd.maVanChuyen, hd.tenDonViVanChuyen, hd.phiVanChuyen, hd.ghiChu) from HoaDon hd where hd.id = :id")
    public HoaDonUserResponse findHoaDonUserResponseById(@Param("id") UUID id);

    @Query("select hd.idGiamGia.soPhanTramGiam from HoaDon hd where hd.id = :id")
    public Integer getSoPhanTramGiamByIdHoaDon(@Param("id") UUID id);

    @Modifying
    @Query("update HoaDon hd set hd.ngayThanhToan = :ngayThanhToan where hd.ma = :ma")
    public void updateNgayThanhToanByIdHoaDon(@Param("ma") String id, @Param("ngayThanhToan") Instant ngayThanhToan);
}
