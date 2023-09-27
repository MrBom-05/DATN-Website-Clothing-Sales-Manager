package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.UUID;
@Repository
public interface GiamGiaRepository extends JpaRepository<GiamGia, UUID> {
}
