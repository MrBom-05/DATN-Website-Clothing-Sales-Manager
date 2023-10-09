package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.AnhSanPham;
import com.example.websitebanquanao.infrastructures.responses.AnhSanPhamResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AnhSanPhamRepository extends JpaRepository<AnhSanPham, UUID> {
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.AnhSanPhamResponse(a.id, a.duongDan) FROM AnhSanPham a where a.idSanPhamChiTiet.id=:id")
    public List<AnhSanPhamResponse> getAll(@Param("id") UUID id);
}