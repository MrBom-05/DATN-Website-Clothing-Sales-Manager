package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.NhanVien;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.NhanVienRequest;
import com.example.websitebanquanao.infrastructures.responses.NhanVienResponse;
import com.example.websitebanquanao.repositories.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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

    public Page<NhanVienResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return nhanVienRepository.getPage(pageable);
    }
    // mã NV tự tăng
    public String maNVCount() {
        String code = "";
        List<NhanVien> list = nhanVienRepository.findAll();
        if (list.isEmpty()) {
            code = "NV0001";
        } else {
            int max = 0;
            for (NhanVien nv : list) {
                String ma = nv.getMa();
                if (ma.length() >= 4) {
                    int so = Integer.parseInt(ma.substring(3));
                    if (so > max) {
                        max = so;
                    }
                }
            }
            max++;
            if (max < 10) {
                code = "NV000" + max;
            } else if (max < 100) {
                code = "NV00" + max;
            } else if (max < 1000) {
                code = "NV0" + max;
            } else {
                code = "NV" + max;
            }
        }
        return code;
    }
    public void add(NhanVienRequest nhanVienRequest) {
        NhanVien nhanVien = new NhanVien();
        nhanVien.setMa(maNVCount());
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

        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        nhanVien.setNgayVaoLam(date);

        nhanVienRepository.save(nhanVien);

        System.out.println("NhanVienService.add: " + nhanVien.getHoVaTen());
    }

    public void update(NhanVienRequest nhanVienRequest, UUID id) {
        NhanVien nhanVien = nhanVienRepository.findById(id).orElse(null);
        if (nhanVien != null) {
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

    public NhanVienResponse getById(UUID id) {
        NhanVienResponse nhanVienResponse = nhanVienRepository.getByIdResponse(id);
        if (nhanVienResponse != null) {
            System.out.println("SanPhamService.findById: " + nhanVienResponse.getHoVaTen());
            return nhanVienResponse;
        } else {
            System.out.println("SanPhamService.findById: null");
            return null;
        }
    }
//    check login
    public NhanVienRequest checkLogin(String email, String matKhau) {;
        NhanVien nhanVien = nhanVienRepository.checkLogin(email, matKhau);
        if (nhanVien != null) {
            NhanVienRequest nhanVienRequest = new NhanVienRequest();
            nhanVienRequest.setId(nhanVien.getId());
            nhanVienRequest.setMa(nhanVien.getMa());
            nhanVienRequest.setHoVaTen(nhanVien.getHoVaTen());
            nhanVienRequest.setEmail(nhanVien.getEmail());
            nhanVienRequest.setSoDienThoai(nhanVien.getSoDienThoai());
            nhanVienRequest.setDiaChi(nhanVien.getDiaChi());
            nhanVienRequest.setXaPhuong(nhanVien.getXaPhuong());
            nhanVienRequest.setQuanHuyen(nhanVien.getQuanHuyen());
            nhanVienRequest.setTinhThanhPho(nhanVien.getTinhThanhPho());
            nhanVienRequest.setChucVu(nhanVien.getChucVu());
            nhanVienRequest.setTrangThai(nhanVien.getTrangThai());

            System.out.println("NhanVienService.checkLogin: " + nhanVienRequest.getHoVaTen());
            return nhanVienRequest;
        } else {
            System.out.println("NhanVienService.checkLogin: null");
            return null;
        }
    }
}
