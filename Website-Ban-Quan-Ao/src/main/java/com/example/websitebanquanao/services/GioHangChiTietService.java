package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.GioHang;
import com.example.websitebanquanao.entities.GioHangChiTiet;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.repositories.GioHangChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.UUID;

@Service
@Transactional
public class GioHangChiTietService {
    @Autowired
    private GioHangChiTietRepository gioHangChiTietRepository;

    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @Autowired
    private GioHangService gioHangService;

    public void add(UUID idSanPham, UUID idKhachHang, GioHangUserRequest gioHangUserRequest) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietService.getByIdSanPhamAndIdMauSacAndIdKichCo(idSanPham, gioHangUserRequest.getIdMauSac(), gioHangUserRequest.getIdKichCo());

        GioHang gioHang = gioHangService.findByIdKhachHang(idKhachHang);

        GioHangChiTiet gioHangChiTiet = new GioHangChiTiet();
        gioHangChiTiet.setIdGioHang(gioHang);
        gioHangChiTiet.setIdSanPhamChiTiet(sanPhamChiTiet);
        gioHangChiTiet.setSoLuong(gioHangUserRequest.getSoLuong());
        gioHangChiTiet.setGia(sanPhamChiTiet.getGia());

        gioHangChiTietRepository.save(gioHangChiTiet);

        System.out.println("GioHangChiTietService.add: " + gioHangChiTiet);
    }

    @Transactional
    public void deleteByIdSanPhamChiTietAndIdKhachHang(UUID idSanPhamChiTiet, UUID idKhachHang) {
        gioHangChiTietRepository.deleteByIdSanPhamChiTietAndIdKhachHang(idSanPhamChiTiet, idKhachHang);
        System.out.println("GioHangChiTietService.deleteByIdSanPhamChiTietAndIdKhachHang: " + idSanPhamChiTiet + " " + idKhachHang);
    }
}
