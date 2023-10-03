package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.KhachHang;
import com.example.beclothingsalesmanager.entities.NhanVien;
import com.example.beclothingsalesmanager.infrastructures.requests.KhachHangRequest;
import com.example.beclothingsalesmanager.infrastructures.requests.NhanVienRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.KhachHangResponse;
import com.example.beclothingsalesmanager.repositories.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;


@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepository khachHangRepository;

    public List<KhachHangResponse> getAll() {
        return khachHangRepository.getAll();
    }

    public void add(KhachHangRequest khachHangRequest) {
        KhachHang khachHang = new KhachHang();
        khachHang.setHoVaTen(khachHangRequest.getHoVaTen());
        khachHang.setEmail(khachHangRequest.getEmail());
        khachHang.setSoDienThoai(khachHangRequest.getSoDienThoai());
        khachHang.setMatKhau(khachHangRequest.getMatKhau());
        khachHang.setDiaChi(khachHangRequest.getDiaChi());
        khachHang.setXaPhuong(khachHangRequest.getXaPhuong());
        khachHang.setQuanHuyen(khachHangRequest.getQuanHuyen());
        khachHang.setTinhThanhPho(khachHangRequest.getTinhThanhPho());

        khachHangRepository.save(khachHang);

        System.out.println("KhachHangService.add: " + khachHang.getHoVaTen());
    }

    public void update(KhachHangRequest khachHangRequest, UUID id) {
        KhachHang khachHang = khachHangRepository.findById(id).orElse(null);
        if (khachHang != null) {
            khachHang.setHoVaTen(khachHangRequest.getHoVaTen());
            khachHang.setEmail(khachHangRequest.getEmail());
            khachHang.setSoDienThoai(khachHangRequest.getSoDienThoai());
            khachHang.setDiaChi(khachHangRequest.getDiaChi());
            khachHang.setXaPhuong(khachHangRequest.getXaPhuong());
            khachHang.setQuanHuyen(khachHangRequest.getQuanHuyen());
            khachHang.setTinhThanhPho(khachHangRequest.getTinhThanhPho());

            khachHangRepository.save(khachHang);

            System.out.println("KhachHangService.update: " + khachHang.getHoVaTen());
        } else {
            System.out.println("KhachHangService.update: null");
        }
    }

    public void delete(UUID id) {
        KhachHang khachHang = khachHangRepository.findById(id).orElse(null);
        if (khachHang != null) {
            khachHangRepository.deleteById(id);

            System.out.println("KhachHangService.delete: " + id);
        } else {
            System.out.println("KhachHangService.delete: null");
        }
    }
}
