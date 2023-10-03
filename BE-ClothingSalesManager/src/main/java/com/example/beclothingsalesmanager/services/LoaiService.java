package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.Loai;
import com.example.beclothingsalesmanager.infrastructures.requests.LoaiRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.LoaiResponse;
import com.example.beclothingsalesmanager.repositories.LoaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoaiService {
    @Autowired
    private LoaiRepository loaiRepository;

    public List<LoaiResponse> getAll() {
        return loaiRepository.getAll();
    }

    public void add(LoaiRequest loaiRequest) {
        Loai loai = new Loai();
        loai.setTen(loaiRequest.getTen());
        loaiRepository.save(loai);

        System.out.println("LoaiService.add: " + loai.getTen());
    }

    public void delete(Integer id) {
        Loai loai = loaiRepository.findById(id).orElse(null);
        if (loai != null) {
            loaiRepository.deleteById(id);

            System.out.println("LoaiService.delete: " + id);
        } else {
            System.out.println("LoaiService.delete: null");
        }
    }
}
