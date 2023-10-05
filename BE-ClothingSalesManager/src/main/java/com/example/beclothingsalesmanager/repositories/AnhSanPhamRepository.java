package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.AnhSanPham;
import com.example.beclothingsalesmanager.infrastructures.responses.AnhSanPhamResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AnhSanPhamRepository extends JpaRepository<AnhSanPham, UUID> {
    @Query("SELECT new com.example.beclothingsalesmanager.infrastructures.responses.AnhSanPhamResponse(a.id, a.duongDan) FROM AnhSanPham a where a.idSanPhamChiTiet.id=:id")
    public List<AnhSanPhamResponse> getAll(@Param("id") UUID id);
}
