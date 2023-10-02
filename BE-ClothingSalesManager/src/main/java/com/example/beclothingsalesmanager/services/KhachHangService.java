package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.KhachHang;
import com.example.beclothingsalesmanager.infrastructures.converts.KhachHangConvert;
import com.example.beclothingsalesmanager.infrastructures.responses.KhachHangResponse;
import com.example.beclothingsalesmanager.repositories.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.UUID;


@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private KhachHangConvert khachHangConvert;


    public Page<KhachHangResponse> findAllPage(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        Page<KhachHang> khachHangPage = khachHangRepository.findAll(pageable);
        Page<KhachHangResponse> khachHangReponsePage = khachHangPage.map(khachHangConvert::mapToViewModel);
        return khachHangReponsePage;
    }

    public void add(KhachHangResponse khachHangResponse) {
        khachHangRepository.save(khachHangConvert.mapToEntity(khachHangResponse));
    }
    public void delete(UUID id) {
        khachHangRepository.deleteById(id);
    }

    public void update(KhachHangResponse khachHangResponse, UUID id){
        khachHangResponse.setId(id);
        khachHangRepository.save(khachHangConvert.mapToEntity(khachHangResponse));
    }

}
