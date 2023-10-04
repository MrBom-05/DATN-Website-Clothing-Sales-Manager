package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.Loai;
import com.example.beclothingsalesmanager.infrastructures.responses.LoaiResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoaiRepository extends JpaRepository<Loai, Integer> {
    @Query("SELECT new com.example.beclothingsalesmanager.infrastructures.responses.LoaiResponse(l.id, l.ten) FROM Loai l ORDER BY l.ten")
    public List<LoaiResponse> getAll();
}
