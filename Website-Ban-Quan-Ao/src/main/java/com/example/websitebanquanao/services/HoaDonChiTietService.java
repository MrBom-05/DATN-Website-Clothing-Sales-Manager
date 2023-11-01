package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.entities.HoaDonChiTiet;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import com.example.websitebanquanao.repositories.HoaDonChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class HoaDonChiTietService {
    @Autowired
    private HoaDonChiTietRepository hoaDonChiTietRepository;

    @Autowired
    private GioHangService gioHangService;

    // admin
    public void add(HoaDonChiTiet hoaDonChiTiet) {
        hoaDonChiTietRepository.save(hoaDonChiTiet);
        System.out.println(hoaDonChiTiet.getId());
    }

    public List<GioHangResponse> getHoaDonChiTietByHoaDonId(UUID hoaDonId) {
        return hoaDonChiTietRepository.findTotalQuantityByHoaDonId(hoaDonId);
    }

    public HoaDonChiTiet getById(UUID id) {
        if (hoaDonChiTietRepository.findById(id).isPresent()) {
            return hoaDonChiTietRepository.findById(id).get();
        } else {
            return null;
        }
    }

    @Transactional
    public void delete(UUID idHoaDonChiTiet) {
        hoaDonChiTietRepository.deleteById(idHoaDonChiTiet);
    }


    public void update(HoaDonChiTiet hoaDonChiTiet) {
        if (hoaDonChiTiet != null && hoaDonChiTiet.getId() != null) {
            hoaDonChiTietRepository.save(hoaDonChiTiet);
        }
    }

    public HoaDonChiTiet getChiTietByHoaDonAndSanPham(UUID idHoaDon, UUID idSanPhamChiTiet) {
        return hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(idHoaDon, idSanPhamChiTiet);
    }

    // user
    public void addHoaDonChiTietUser(HoaDon hoaDon, UUID idKhachHang) {
        List<GioHangUserResponse> listSanPhamGioHang = gioHangService.getListByIdKhachHang(idKhachHang);

        for (GioHangUserResponse gioHangUserResponse : listSanPhamGioHang) {
            HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
            hoaDonChiTiet.setIdHoaDon(hoaDon);
            SanPhamChiTiet sanPhamChiTiet = new SanPhamChiTiet();
            sanPhamChiTiet.setId(gioHangUserResponse.getIdSanPhamChiTiet());
            hoaDonChiTiet.setIdSanPhamChiTiet(sanPhamChiTiet);
            hoaDonChiTiet.setSoLuong(gioHangUserResponse.getSoLuong());
            hoaDonChiTiet.setGia(gioHangUserResponse.getGia());
            hoaDonChiTietRepository.save(hoaDonChiTiet);
        }
        System.out.println("HoaDonChiTietService.addHoaDonChiTietUser: " + hoaDon.getMa());
    }
}
