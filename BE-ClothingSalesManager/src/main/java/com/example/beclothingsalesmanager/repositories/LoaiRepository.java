package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.Loai;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoaiRepository extends JpaRepository<Loai, Integer> {
}
