package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.infrastructures.requests.HoaDonRequest;
import com.example.websitebanquanao.repositories.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class HoaDonService {
    @Autowired
    private HoaDonRepository hoaDonRepository;

    public List<HoaDon> getAll() {
        return hoaDonRepository.findAll();
    }
    public String maHDCount() {
        String code = "";
        List<HoaDon> list = hoaDonRepository.findAll();
        if (list.isEmpty()) {
            code = "HD0001";
        } else {
            int max = 0;
            for (HoaDon hd : list) {
                String ma = hd.getMa();
                if (ma.length() >= 4) {
                    int so = Integer.parseInt(ma.substring(3));
                    if (so > max) {
                        max = so;
                    }
                }
            }
            max++;
            if (max < 10) {
                code = "HD000" + max;
            } else if (max < 100) {
                code = "HD00" + max;
            } else if (max < 1000) {
                code = "HD0" + max;
            } else {
                code = "HD" + max;
            }
        }
        return code;
    }
    public void add(HoaDonRequest hoaDonRequest){
        HoaDon hoaDon = new HoaDon();
        hoaDon.setMa(maHDCount());
        hoaDon.setNgayTao(hoaDonRequest.getNgayTao());
        hoaDon.setNgayThanhToan(hoaDonRequest.getNgayThanhToan());
        hoaDon.setNgayVanChuyen(hoaDonRequest.getNgayVanChuyen());
        hoaDon.setNgayNhan(hoaDonRequest.getNgayNhan());
        hoaDon.setIdKhachHang(hoaDonRequest.getIdKhachHang());
        hoaDon.setIdNhanVien(hoaDonRequest.getIdNhanVien());
        hoaDon.setIdGiamGia(hoaDonRequest.getIdGiamGia());
        hoaDon.setNguoiNhan(hoaDonRequest.getNguoiNhan());
        hoaDon.setEmail(hoaDonRequest.getEmail());
        hoaDon.setSoDienThoai(hoaDonRequest.getSoDienThoai());
        hoaDon.setHinhThucThanhToan(hoaDonRequest.getHinhThucThanhToan());
        hoaDon.setDiaChi(hoaDonRequest.getDiaChi());
        hoaDon.setXaPhuong(hoaDonRequest.getXaPhuong());
        hoaDon.setQuanHuyen(hoaDonRequest.getQuanHuyen());
        hoaDon.setTinhThanhPho(hoaDonRequest.getTinhThanhPho());
        hoaDon.setTrangThai(hoaDonRequest.getTrangThai());
        hoaDon.setLoaiHoaDon(hoaDonRequest.getLoaiHoaDon());
        hoaDonRepository.save(hoaDon);
        System.out.println("HoaDonService.add: " + hoaDon.getMa());
    }

    public HoaDon getById(UUID idHoaDon) {
        if (hoaDonRepository.findById(idHoaDon).isPresent()) {
            return hoaDonRepository.findById(idHoaDon).get();
        }else {
            return null;
        }
    }
    public HoaDon findHoaDonByHoaDonChiTietId(UUID idHoaDonChiTiet) {
        return hoaDonRepository.findHoaDonByHoaDonChiTietId(idHoaDonChiTiet);
    }

    public void update(HoaDon hoaDon, UUID idHoaDon) {
        if (hoaDon != null && idHoaDon != null) {
            hoaDonRepository.save(hoaDon);
        }
    }
}
