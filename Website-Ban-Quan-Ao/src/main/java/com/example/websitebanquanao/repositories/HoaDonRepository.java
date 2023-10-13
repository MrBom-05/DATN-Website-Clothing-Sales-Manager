package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface HoaDonRepository extends JpaRepository<HoaDon, UUID> {
    @Query("SELECT hd FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hdct.id = :idHoaDonChiTiet")
    HoaDon findHoaDonByHoaDonChiTietId(@Param("idHoaDonChiTiet") UUID idHoaDonChiTiet);
}
