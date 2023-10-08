package com.example.websitebanquanao.repositories;


import com.example.websitebanquanao.entities.MauSac;
import com.example.websitebanquanao.infrastructures.responses.MauSacResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MauSacRepository extends JpaRepository<MauSac, Integer> {
    @Query("select new com.example.websitebanquanao.infrastructures.responses.MauSacResponse(m.id, m.ten, m.maMauSac) from MauSac m ORDER BY m.ten")
    public List<MauSacResponse> getAll();
}
