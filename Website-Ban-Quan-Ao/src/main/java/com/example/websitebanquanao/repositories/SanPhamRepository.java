package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.SanPham;
import com.example.websitebanquanao.infrastructures.responses.SanPhamResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, UUID> {
    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp ORDER BY sp.ten")
    public List<SanPhamResponse> getAll();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp ORDER BY sp.ten")
    public Page<SanPhamResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp where sp.id = :id")
    public SanPhamResponse getByIdResponse(@Param("id") UUID id);
}
