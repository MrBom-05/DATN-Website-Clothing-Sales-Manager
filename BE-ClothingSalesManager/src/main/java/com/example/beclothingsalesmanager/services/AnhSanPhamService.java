package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.AnhSanPham;
import com.example.beclothingsalesmanager.entities.SanPhamChiTiet;
import com.example.beclothingsalesmanager.infrastructures.requests.AnhSanPhamRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.AnhSanPhamResponse;
import com.example.beclothingsalesmanager.repositories.AnhSanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class AnhSanPhamService {
    @Autowired
    private AnhSanPhamRepository anhSanPhamRepository;

    public List<AnhSanPhamResponse> getAll(UUID id) {
        return anhSanPhamRepository.getAll(id);
    }

    public void add(SanPhamChiTiet sanPhamChiTiet, List<String> duongDan) {
        for (String string : duongDan) {
            AnhSanPham anhSanPham = new AnhSanPham();
            anhSanPham.setDuongDan(string);
            anhSanPham.setIdSanPhamChiTiet(sanPhamChiTiet);
            anhSanPhamRepository.save(anhSanPham);
        }
        System.out.println("AnhSanPhamService.add: " + sanPhamChiTiet.getId());
    }

    public void update(AnhSanPhamRequest anhSanPhamRequest, UUID id) {
        AnhSanPham anhSanPham = anhSanPhamRepository.findById(id).orElse(null);
        if (anhSanPham != null) {
            anhSanPham.setDuongDan(anhSanPhamRequest.getDuongDan());

            anhSanPhamRepository.save(anhSanPham);

            System.out.println("AnhSanPhamService.update: " + id);
        }
    }

    public void delete(UUID id) {
        AnhSanPham anhSanPham = anhSanPhamRepository.findById(id).orElse(null);
        if (anhSanPham != null) {
            anhSanPhamRepository.deleteById(id);

            System.out.println("AnhSanPhamService.delete: " + id);
        }
    }
}
