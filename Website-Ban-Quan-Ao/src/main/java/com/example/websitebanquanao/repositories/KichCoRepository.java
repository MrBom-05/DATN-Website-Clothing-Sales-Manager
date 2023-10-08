package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.KichCo;
import com.example.websitebanquanao.infrastructures.responses.KichCoResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface KichCoRepository extends JpaRepository<KichCo, Integer> {
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.KichCoResponse(k.id, k.ten) FROM KichCo k ORDER BY k.ten")
    public List<KichCoResponse> getAll();
}
