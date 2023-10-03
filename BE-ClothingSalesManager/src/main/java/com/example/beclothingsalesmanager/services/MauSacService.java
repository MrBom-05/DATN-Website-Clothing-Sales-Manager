package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.MauSac;
import com.example.beclothingsalesmanager.infrastructures.requests.MauSacRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.MauSacResponse;
import com.example.beclothingsalesmanager.repositories.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MauSacService {
    @Autowired
    private MauSacRepository mauSacRepository;


    public List<MauSacResponse> getAll() {
        return mauSacRepository.getAll();
    }

    public void add(MauSacRequest mauSacRequest) {
        MauSac mauSac = new MauSac();
        mauSac.setTen(mauSacRequest.getTen());
        mauSac.setMaMauSac(mauSacRequest.getMaMauSac());
        mauSacRepository.save(mauSac);

        System.out.println("MauSacService.add: " + mauSac.getTen());
    }

    public void delete(int id) {
        MauSac mauSac = mauSacRepository.findById(id).orElse(null);
        if (mauSac != null) {
            mauSacRepository.deleteById(id);

            System.out.println("MauSacService.delete: " + id);
        } else {
            System.out.println("MauSacService.delete: null");
        }
    }
}
