package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.NhanVien;
import com.example.beclothingsalesmanager.infrastructures.requests.NhanVienRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.NhanVienResponse;
import com.example.beclothingsalesmanager.repositories.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class NhanVienService {
    @Autowired
    private NhanVienRepository nhanVienRepository;

    public List<NhanVienResponse> getAll() {
        return nhanVienRepository.getAll();
    }

    public void add(NhanVienRequest nhanVienRequest) {
        NhanVien nhanVien = new NhanVien();
        nhanVien.setMa(nhanVienRequest.getMa());
        nhanVien.setHoVaTen(nhanVienRequest.getHoVaTen());
        nhanVien.setEmail(nhanVienRequest.getEmail());
        nhanVien.setSoDienThoai(nhanVienRequest.getSoDienThoai());
        nhanVien.setMatKhau(nhanVienRequest.getMatKhau());
        nhanVien.setDiaChi(nhanVienRequest.getDiaChi());
        nhanVien.setXaPhuong(nhanVienRequest.getXaPhuong());
        nhanVien.setQuanHuyen(nhanVienRequest.getQuanHuyen());
        nhanVien.setTinhThanhPho(nhanVienRequest.getTinhThanhPho());
        nhanVien.setChucVu(nhanVienRequest.getChucVu());
        nhanVien.setTrangThai(nhanVienRequest.getTrangThai());

        nhanVienRepository.save(nhanVien);

        System.out.println("NhanVienService.add: " + nhanVien.getHoVaTen());
    }

    public void update(NhanVienRequest nhanVienRequest, UUID id) {
        NhanVien nhanVien = nhanVienRepository.findById(id).orElse(null);
        if (nhanVien != null) {
            nhanVien.setMa(nhanVienRequest.getMa());
            nhanVien.setHoVaTen(nhanVienRequest.getHoVaTen());
            nhanVien.setEmail(nhanVienRequest.getEmail());
            nhanVien.setSoDienThoai(nhanVienRequest.getSoDienThoai());
            nhanVien.setDiaChi(nhanVienRequest.getDiaChi());
            nhanVien.setXaPhuong(nhanVienRequest.getXaPhuong());
            nhanVien.setQuanHuyen(nhanVienRequest.getQuanHuyen());
            nhanVien.setTinhThanhPho(nhanVienRequest.getTinhThanhPho());
            nhanVien.setChucVu(nhanVienRequest.getChucVu());
            nhanVien.setTrangThai(nhanVienRequest.getTrangThai());

            nhanVienRepository.save(nhanVien);

            System.out.println("NhanVienService.update: " + nhanVien.getHoVaTen());
        } else {
            System.out.println("NhanVienService.update: null");
        }
    }

    public void delete(UUID id) {
        NhanVien nhanVien = nhanVienRepository.findById(id).orElse(null);
        if (nhanVien != null) {
            nhanVienRepository.deleteById(id);

            System.out.println("NhanVienService.delete: " + id);
        } else {
            System.out.println("NhanVienService.delete: null");
        }
    }
}
