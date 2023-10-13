package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.GioHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface GioHangChiTietRepository extends JpaRepository<GioHangChiTiet, UUID> {
    @Modifying
    @Query("DELETE FROM GioHangChiTiet ghct WHERE ghct.idSanPhamChiTiet.id = :idSanPhamChiTiet AND ghct.idGioHang.idKhachHang.id = :idKhachHang")
    void deleteByIdSanPhamChiTietAndIdKhachHang(@Param("idSanPhamChiTiet") UUID idSanPhamChiTiet, @Param("idKhachHang") UUID idKhachHang);
}
