package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.GiamGia;
import com.example.websitebanquanao.infrastructures.requests.GiamGiaRequest;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import com.example.websitebanquanao.repositories.GiamGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class GiamGiaService {
    @Autowired
    private GiamGiaRepository giamGiaRepository;

    public Page<GiamGiaResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return giamGiaRepository.getPage(pageable);
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

    public GiamGiaResponse getById(UUID id) {
        GiamGiaResponse giamGiaResponse = giamGiaRepository.getByIdResponse(id);
        if (giamGiaResponse != null) {
            System.out.println("GiamGiaService.findById: " + giamGiaResponse.getMa());
            return giamGiaResponse;
        } else {
            System.out.println("GiamGiaService.findById: null");
            return null;
        }
    }
}
