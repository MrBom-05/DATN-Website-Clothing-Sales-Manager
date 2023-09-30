package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.KichCo;
import com.example.beclothingsalesmanager.infrastructures.responses.KichCoResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface KichCoRepository extends JpaRepository<KichCo, Integer> {
    @Query("SELECT new com.example.beclothingsalesmanager.infrastructures.responses.KichCoResponse(k.id, k.ten) FROM KichCo k")
    public List<KichCoResponse> getAll();
}
