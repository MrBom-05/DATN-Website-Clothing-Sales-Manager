package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.MauSac;
import com.example.beclothingsalesmanager.infrastructures.converts.MauSacConvert;
import com.example.beclothingsalesmanager.infrastructures.responses.MauSacReponse;
import com.example.beclothingsalesmanager.repositories.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class MauSacService {
    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private MauSacConvert mauSacConvert;


    public Page<MauSacReponse> findAllPage(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        Page<MauSac> mauSacPage = mauSacRepository.findAll(pageable);
        Page<MauSacReponse> mauSacReponses = mauSacPage.map(mauSacConvert::mapToViewModel);
        return mauSacReponses;
    }

    public void add(MauSacReponse mauSacReponse) {
        mauSacRepository.save(mauSacConvert.mapToEntity(mauSacReponse));
    }
    public void delete(Integer id) {
        mauSacRepository.deleteById(id);
    }

    public void update(MauSacReponse mauSacReponse, Integer id){
        mauSacReponse.setId(id);
        mauSacRepository.save(mauSacConvert.mapToEntity(mauSacReponse));
    }
}
