package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.SanPhamChiTiet;
import com.example.beclothingsalesmanager.infrastructures.responses.SanPhamChiTietResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet, UUID> {
    @Query("select new com.example.beclothingsalesmanager.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai) from SanPhamChiTiet s")
    public List<SanPhamChiTietResponse> getAll();
}
