package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;
import java.util.stream.Stream;

public interface HoaDonRepository extends JpaRepository<HoaDon, UUID> {
    @Query("SELECT hd FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hdct.id = :idHoaDonChiTiet")
    HoaDon findHoaDonByHoaDonChiTietId(@Param("idHoaDonChiTiet") UUID idHoaDonChiTiet);

//    @Query("SELECT hd FROM HoaDon hd where hd.trangThai = :trangThai")
//    List<HoaDon> findHoaDonByTrangThai(@Param("trangThai") Integer trangThai);

    @Query("SELECT hd FROM HoaDon hd where hd.trangThai = 0 order by hd.ma desc ")
    List<HoaDon> findAllHoaDon();
}
