package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.KhuyenMai;
import com.example.websitebanquanao.infrastructures.requests.KhuyenMaiRequest;
import com.example.websitebanquanao.infrastructures.responses.KhuyenMaiResponse;
import com.example.websitebanquanao.repositories.KhuyenMaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
public class KhuyenMaiService {
    @Autowired
    private KhuyenMaiRepository khuyenMaiRepository;

    public Page<KhuyenMaiResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return khuyenMaiRepository.getPage(pageable);
    }

    public void add(KhuyenMaiRequest khuyenMaiRequest) {
        KhuyenMai khuyenMai = new KhuyenMai();
        khuyenMai.setMa(khuyenMaiRequest.getMa());
        khuyenMai.setTen(khuyenMaiRequest.getTen());
        khuyenMai.setSoPhanTramGiam(khuyenMaiRequest.getSoPhanTramGiam());
        khuyenMai.setNgayBatDau(khuyenMaiRequest.getNgayBatDau());
        khuyenMai.setNgayKetThuc(khuyenMaiRequest.getNgayKetThuc());
        khuyenMai.setTrangThai(0);

        khuyenMaiRepository.save(khuyenMai);

        System.out.println("KhuyenMaiService.add: " + khuyenMai.getMa());
    }

    public void update(KhuyenMaiRequest khuyenMaiRequest, UUID id) {
        KhuyenMai khuyenMai = khuyenMaiRepository.findById(id).orElse(null);
        if (khuyenMai != null) {
            khuyenMai.setMa(khuyenMaiRequest.getMa());
            khuyenMai.setTen(khuyenMaiRequest.getTen());
            khuyenMai.setSoPhanTramGiam(khuyenMaiRequest.getSoPhanTramGiam());
            khuyenMai.setNgayBatDau(khuyenMaiRequest.getNgayBatDau());
            khuyenMai.setNgayKetThuc(khuyenMaiRequest.getNgayKetThuc());
            khuyenMai.setTrangThai(0);

            khuyenMaiRepository.save(khuyenMai);

            System.out.println("KhuyenMaiService.update: " + khuyenMai.getMa());
        } else {
            System.out.println("KhuyenMaiService.update: null");
        }
    }

    @Transactional
    public void updateTrangThai(UUID id, int trangThai) {
        khuyenMaiRepository.updateTrangThaiById(id, trangThai);
        System.out.println("KhuyenMaiService.updateTrangThai: " + id);
    }

    public void delete(UUID id) {
        KhuyenMai khuyenMai = khuyenMaiRepository.findById(id).orElse(null);
        if (khuyenMai != null) {
            khuyenMaiRepository.deleteById(id);
            System.out.println("KhuyenMaiService.delete: " + khuyenMai.getMa());
        } else {
            System.out.println("KhuyenMaiService.delete: null");
        }
    }

    public KhuyenMaiResponse getById(UUID id) {
        KhuyenMaiResponse khuyenMaiResponse = khuyenMaiRepository.getByIdResponse(id);
        if (khuyenMaiResponse != null) {
            System.out.println("KhuyenMaiService.getById: " + khuyenMaiResponse.getMa());
            return khuyenMaiResponse;
        } else {
            System.out.println("KhuyenMaiService.getById: null");
            return null;
        }
    }
}
