package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface GiamGiaRepository extends JpaRepository<GiamGia, UUID> {
    @Query("select new com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc) from GiamGia g")
    public List<GiamGiaResponse> getAll();
}
