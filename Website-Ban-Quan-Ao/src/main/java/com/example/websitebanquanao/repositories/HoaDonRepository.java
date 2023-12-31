package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.infrastructures.responses.HoaDonChiTietUserResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public interface HoaDonRepository extends JpaRepository<HoaDon, UUID> {

    // admin
    @Query("SELECT hd FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hdct.id = :idHoaDonChiTiet")
    HoaDon findHoaDonByHoaDonChiTietId(@Param("idHoaDonChiTiet") UUID idHoaDonChiTiet);

    @Query("SELECT hd FROM HoaDon hd order by hd.ma desc ")
    List<HoaDon> findAllHd();

    @Query("SELECT hd FROM HoaDon hd where hd.trangThai = 0 order by hd.ma desc ")
    List<HoaDon> findAllHoaDon();

    @Modifying
    @Transactional
    @Query("update HoaDon hd set hd.trangThai = 1 where hd.id = :id")
    public void updateDaThanhToanHoaDon(@Param("id") UUID id);

    // user
    @Query("select new com.example.websitebanquanao.infrastructures.responses.HoaDonChiTietUserResponse(hd.ma, hd.trangThai, hd.hinhThucThanhToan, hd.ngayTao, hd.ngayThanhToan, hd.ngayVanChuyen, hd.ngayNhan, hd.nguoiNhan, hd.diaChi, hd.xaPhuong, hd.quanHuyen, hd.tinhThanhPho, hd.email, hd.soDienThoai, hd.maVanChuyen, hd.tenDonViVanChuyen, hd.phiVanChuyen) from HoaDon hd where hd.id = :id")
    public HoaDonChiTietUserResponse findHoaDonUserResponseById(@Param("id") UUID id);

    @Query("select hd.idGiamGia.soPhanTramGiam from HoaDon hd where hd.id = :id")
    public Integer getSoPhanTramGiamByIdHoaDon(@Param("id") UUID id);

    @Modifying
    @Query("update HoaDon hd set hd.ngayThanhToan = :ngayThanhToan, hd.trangThai = :trangThai where hd.ma = :ma")
    public void updateNgayThanhToanByIdHoaDon(@Param("ma") String ma, @Param("ngayThanhToan") Instant ngayThanhToan, @Param("trangThai") Integer trangThai);
}
