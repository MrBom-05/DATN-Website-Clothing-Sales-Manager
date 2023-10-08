package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.Loai;
import com.example.websitebanquanao.entities.SanPham;
import com.example.websitebanquanao.infrastructures.requests.SanPhamRequest;
import com.example.websitebanquanao.infrastructures.responses.SanPhamResponse;
import com.example.websitebanquanao.repositories.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class SanPhamService {
    @Autowired
    private SanPhamRepository sanPhamRepository;

    public List<SanPhamResponse> getAll() {
        return sanPhamRepository.getAll();
    }

    public void add(SanPhamRequest sanPhamRequest) {
        SanPham sanPham = new SanPham();
        sanPham.setTen(sanPhamRequest.getTen());

        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        sanPham.setNgayTao(date);

        Loai loai = new Loai();
        loai.setId(sanPhamRequest.getIdLoai());

        sanPham.setIdLoai(loai);
        sanPhamRepository.save(sanPham);

        System.out.println("SanPhamService.add: " + sanPham.getTen());
    }

    public void update(SanPhamRequest sanPhamRequest, UUID id) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham != null) {
            sanPham.setTen(sanPhamRequest.getTen());

            Loai loai = new Loai();
            loai.setId(sanPhamRequest.getIdLoai());

            sanPham.setIdLoai(loai);

            sanPhamRepository.save(sanPham);

            System.out.println("SanPhamService.update: " + sanPham.getTen());
        } else {
            System.out.println("SanPhamService.update: null");
        }
    }

    public void delete(UUID id) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham != null) {
            sanPhamRepository.delete(sanPham);

            System.out.println("SanPhamService.delete: " + sanPham.getTen());
        } else {
            System.out.println("SanPhamService.delete: null");
        }
    }
}
