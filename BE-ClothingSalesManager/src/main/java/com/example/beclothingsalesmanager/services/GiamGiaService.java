package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.infrastructures.converts.GiamGiaConvert;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.repositories.GiamGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class GiamGiaService {
    @Autowired
    private GiamGiaRepository giamGiaRepository;

    @Autowired
    private GiamGiaConvert giamGiaConvert;

    public Page<GiamGiaResponse> findAllPage(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        Page<GiamGia> giamGiaPage = giamGiaRepository.findAll(pageable);
        Page<GiamGiaResponse> giamGiaResponsePage = giamGiaPage.map(giamGiaConvert::mapToViewModel);
        return giamGiaResponsePage;
    }

    public void add(GiamGiaResponse giamGiaResponse) {
        giamGiaRepository.save(giamGiaConvert.mapToEntity(giamGiaResponse));
    }

    public void delete(UUID id) {
        giamGiaRepository.deleteById(id);
    }

    public void update(GiamGiaResponse giamGiaResponse, UUID id){
        giamGiaResponse.setId(id);
        giamGiaRepository.save(giamGiaConvert.mapToEntity(giamGiaResponse));
    }

}
