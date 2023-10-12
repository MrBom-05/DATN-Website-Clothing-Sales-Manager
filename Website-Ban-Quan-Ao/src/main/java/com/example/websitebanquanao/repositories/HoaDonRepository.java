package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface HoaDonRepository extends JpaRepository<HoaDon, UUID> {
}