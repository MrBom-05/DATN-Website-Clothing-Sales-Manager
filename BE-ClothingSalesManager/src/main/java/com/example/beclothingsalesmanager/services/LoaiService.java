package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.Loai;
import com.example.beclothingsalesmanager.infrastructures.converts.LoaiConvert;
import com.example.beclothingsalesmanager.infrastructures.responses.LoaiReponse;
import com.example.beclothingsalesmanager.repositories.LoaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class LoaiService {
    @Autowired
    private LoaiRepository loaiRepository;

    @Autowired
    private LoaiConvert loaiConvert;


    public Page<LoaiReponse> findAllPage(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        Page<Loai> loaiPage = loaiRepository.findAll(pageable);
        Page<LoaiReponse> loaiReponsePage = loaiPage.map(loaiConvert::mapToViewModel);
        return loaiReponsePage;
    }

    public void add(LoaiReponse loaiReponse) {
        loaiRepository.save(loaiConvert.mapToEntity(loaiReponse));
    }
    public void delete(Integer id) {
        loaiRepository.deleteById(id);
    }

    public void update(LoaiReponse loaiReponse, Integer id){
        loaiReponse.setId(id);
        loaiRepository.save(loaiConvert.mapToEntity(loaiReponse));
    }
}
