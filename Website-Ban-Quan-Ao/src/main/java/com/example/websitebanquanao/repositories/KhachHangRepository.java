package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.KhachHang;
import com.example.websitebanquanao.infrastructures.responses.KhachHangResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang, UUID> {
    @Query("select new com.example.websitebanquanao.infrastructures.responses.KhachHangResponse(kh.id, kh.hoVaTen, kh.soDienThoai, kh.email, kh.diaChi, kh.xaPhuong, kh.quanHuyen, kh.tinhThanhPho) from KhachHang kh")
    public List<KhachHangResponse> getAll();
}
