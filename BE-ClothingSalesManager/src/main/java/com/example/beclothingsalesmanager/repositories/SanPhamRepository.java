package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.SanPham;
import com.example.beclothingsalesmanager.infrastructures.responses.SanPhamResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, UUID> {
    @Query("select new com.example.beclothingsalesmanager.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.idLoai.ten, sp.idMauSac.ten) from SanPham sp")
    public List<SanPhamResponse> getAll();
}
