package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.entities.KhuyenMai;
import com.example.beclothingsalesmanager.infrastructures.converts.GiamGiaConvert;
import com.example.beclothingsalesmanager.infrastructures.converts.KhuyenMaiConvert;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.infrastructures.responses.KhuyenMaiResponse;
import com.example.beclothingsalesmanager.repositories.GiamGiaRepository;
import com.example.beclothingsalesmanager.repositories.KhuyenMaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class KhuyenMaiService {
    @Autowired
    private KhuyenMaiRepository khuyenMaiRepository;

    @Autowired
    private KhuyenMaiConvert khuyenMaiConvert;

    public Page<KhuyenMaiResponse> findAllPage(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        Page<KhuyenMai> khuyenMaiPage = khuyenMaiRepository.findAll(pageable);
        Page<KhuyenMaiResponse> khuyenMaiResponses = khuyenMaiPage.map(khuyenMaiConvert::mapToViewModel);
        return khuyenMaiResponses;
    }

    public void add(KhuyenMaiResponse giamGiaResponse) {
        khuyenMaiRepository.save(khuyenMaiConvert.mapToEntity(giamGiaResponse));
    }

    public void delete(UUID id) {
        khuyenMaiRepository.deleteById(id);
    }

    public void update(KhuyenMaiResponse khuyenMaiResponse, UUID id) {
        khuyenMaiResponse.setId(id);
        khuyenMaiRepository.save(khuyenMaiConvert.mapToEntity(khuyenMaiResponse));
    }


}
