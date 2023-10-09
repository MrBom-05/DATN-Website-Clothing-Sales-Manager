package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.MauSac;
import com.example.websitebanquanao.infrastructures.requests.MauSacRequest;
import com.example.websitebanquanao.infrastructures.responses.MauSacResponse;
import com.example.websitebanquanao.repositories.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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

    public void update(MauSacRequest mauSacRequest,Integer id) {
        MauSac mauSac = mauSacRepository.findById(id).orElse(null);
        if(mauSac != null){
            mauSac.setMaMauSac(mauSacRequest.getMaMauSac());
            mauSac.setTen(mauSacRequest.getTen());
            mauSacRepository.save(mauSac);
            System.out.println("mauSacService.update: " + mauSac.getTen());
        } else {
            System.out.println("mauSacService.update: null");
        }

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

    public MauSac findById(Integer id) {
        if (mauSacRepository.findById(id).isPresent()) {
            return mauSacRepository.findById(id).get();
        }else {
            return null;
        }
    }

    public Page<MauSac> getAllWithPagination(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return mauSacRepository.findAll(pageable);
    }
}
