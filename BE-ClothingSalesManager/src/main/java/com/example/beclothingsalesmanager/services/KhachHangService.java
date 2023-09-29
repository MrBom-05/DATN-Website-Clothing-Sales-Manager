package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.KhachHang;
import com.example.beclothingsalesmanager.infrastructures.converts.KhachHangConvert;
import com.example.beclothingsalesmanager.infrastructures.responses.KhachHangReponse;
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


    public Page<KhachHangReponse> findAllPage(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        Page<KhachHang> khachHangPage = khachHangRepository.findAll(pageable);
        Page<KhachHangReponse> khachHangReponsePage = khachHangPage.map(khachHangConvert::mapToViewModel);
        return khachHangReponsePage;
    }

    public void add(KhachHangReponse khachHangReponse) {
        khachHangRepository.save(khachHangConvert.mapToEntity(khachHangReponse));
    }
    public void delete(UUID id) {
        khachHangRepository.deleteById(id);
    }

    public void update(KhachHangReponse khachHangReponse, UUID id){
        khachHangReponse.setId(id);
        khachHangRepository.save(khachHangConvert.mapToEntity(khachHangReponse));
    }

}
