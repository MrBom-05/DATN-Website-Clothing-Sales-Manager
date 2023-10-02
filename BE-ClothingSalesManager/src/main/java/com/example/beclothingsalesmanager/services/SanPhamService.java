package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.Loai;
import com.example.beclothingsalesmanager.entities.MauSac;
import com.example.beclothingsalesmanager.entities.SanPham;
import com.example.beclothingsalesmanager.infrastructures.requests.SanPhamRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.SanPhamResponse;
import com.example.beclothingsalesmanager.repositories.SanPhamRepository;
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
        Loai loai = new Loai();
        loai.setId(sanPhamRequest.getIdLoai());

        MauSac mauSac = new MauSac();
        mauSac.setId(sanPhamRequest.getIdMauSac());

        SanPham sanPham = new SanPham();
        sanPham.setTen(sanPhamRequest.getTen());
        sanPham.setIdLoai(loai);
        sanPham.setIdMauSac(mauSac);

        sanPhamRepository.save(sanPham);
    }

    public void update(SanPhamRequest sanPhamRequest, UUID id) {
        Loai loai = new Loai();
        loai.setId(sanPhamRequest.getIdLoai());

        MauSac mauSac = new MauSac();
        mauSac.setId(sanPhamRequest.getIdMauSac());

        SanPham sanPham = new SanPham();
        sanPham.setId(id);
        sanPham.setTen(sanPhamRequest.getTen());
        sanPham.setIdLoai(loai);
        sanPham.setIdMauSac(mauSac);

        sanPhamRepository.save(sanPham);
    }

    public void delete(UUID id) {
        sanPhamRepository.deleteById(id);
    }
}
