package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.infrastructures.requests.GiamGiaRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.repositories.GiamGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class GiamGiaService {
    @Autowired
    private GiamGiaRepository giamGiaRepository;

    public List<GiamGiaResponse> getAll() {
        return giamGiaRepository.getAll();
    }

    public void add(GiamGiaRequest giamGiaRequest) {
        GiamGia giamGia = new GiamGia();
        giamGia.setMa(giamGiaRequest.getMa());
        giamGia.setSoPhanTramGiam(giamGiaRequest.getSoPhanTramGiam());
        giamGia.setSoLuong(giamGiaRequest.getSoLuong());
        giamGia.setNgayBatDau(giamGiaRequest.getNgayBatDau());
        giamGia.setNgayKetThuc(giamGiaRequest.getNgayKetThuc());

        giamGiaRepository.save(giamGia);

        System.out.println("GiamGiaService.add: " + giamGia.getMa());
    }

    public void update(GiamGiaRequest giamGiaRequest, UUID id) {
        GiamGia giamGia = giamGiaRepository.findById(id).orElse(null);
        if (giamGia != null) {
            giamGia.setMa(giamGiaRequest.getMa());
            giamGia.setSoPhanTramGiam(giamGiaRequest.getSoPhanTramGiam());
            giamGia.setSoLuong(giamGiaRequest.getSoLuong());
            giamGia.setNgayBatDau(giamGiaRequest.getNgayBatDau());
            giamGia.setNgayKetThuc(giamGiaRequest.getNgayKetThuc());

            giamGiaRepository.save(giamGia);

            System.out.println("GiamGiaService.update: " + giamGia.getMa());
        } else {
            System.out.println("GiamGiaService.update: null");
        }
    }

    public void delete(UUID id) {
        GiamGia giamGia = giamGiaRepository.findById(id).orElse(null);
        if (giamGia != null) {
            giamGiaRepository.deleteById(id);

            System.out.println("GiamGiaService.delete: " + id);
        } else {
            System.out.println("GiamGiaService.delete: null");
        }
    }
}
