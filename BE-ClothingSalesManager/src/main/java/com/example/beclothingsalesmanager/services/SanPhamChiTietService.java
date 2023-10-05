package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.KichCo;
import com.example.beclothingsalesmanager.entities.MauSac;
import com.example.beclothingsalesmanager.entities.SanPham;
import com.example.beclothingsalesmanager.entities.SanPhamChiTiet;
import com.example.beclothingsalesmanager.infrastructures.requests.SanPhamChiTietRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.SanPhamChiTietResponse;
import com.example.beclothingsalesmanager.repositories.SanPhamChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class SanPhamChiTietService {
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;
    @Autowired
    private AnhSanPhamService anhSanPhamService;

    public List<SanPhamChiTietResponse> getAll() {
        return sanPhamChiTietRepository.getAll();
    }


    public void add(SanPhamChiTietRequest sanPhamChiTietRequest) {
        SanPhamChiTiet sanPhamChiTiet = new SanPhamChiTiet();
        sanPhamChiTiet.setMaSanPham(sanPhamChiTietRequest.getMaSanPham());
        sanPhamChiTiet.setGia(sanPhamChiTietRequest.getGia());
        sanPhamChiTiet.setSoLuong(sanPhamChiTietRequest.getSoLuong());
        sanPhamChiTiet.setMoTa(sanPhamChiTietRequest.getMoTa());
        sanPhamChiTiet.setTrangThai(sanPhamChiTietRequest.getTrangThai());

        SanPham sanPham = new SanPham();
        sanPham.setId(sanPhamChiTietRequest.getIdSanPham());

        MauSac mauSac = new MauSac();
        mauSac.setId(sanPhamChiTietRequest.getIdMauSac());

        KichCo kichCo = new KichCo();
        kichCo.setId(sanPhamChiTietRequest.getIdKichCo());

        sanPhamChiTiet.setIdSanPham(sanPham);
        sanPhamChiTiet.setIdMauSac(mauSac);
        sanPhamChiTiet.setIdKichCo(kichCo);

        SanPhamChiTiet sanPhamChiTietSaved = sanPhamChiTietRepository.save(sanPhamChiTiet);
        anhSanPhamService.add(sanPhamChiTietSaved, sanPhamChiTietRequest.getDuongDan());

        System.out.println("SanPhamChiTietService.add: " + sanPhamChiTietSaved.getId());
    }

    public void update(SanPhamChiTietRequest sanPhamChiTietRequest, UUID id) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet != null) {
            sanPhamChiTiet.setMaSanPham(sanPhamChiTietRequest.getMaSanPham());
            sanPhamChiTiet.setGia(sanPhamChiTietRequest.getGia());
            sanPhamChiTiet.setSoLuong(sanPhamChiTietRequest.getSoLuong());
            sanPhamChiTiet.setMoTa(sanPhamChiTietRequest.getMoTa());
            sanPhamChiTiet.setTrangThai(sanPhamChiTietRequest.getTrangThai());

            SanPham sanPham = new SanPham();
            sanPham.setId(sanPhamChiTietRequest.getIdSanPham());

            MauSac mauSac = new MauSac();
            mauSac.setId(sanPhamChiTietRequest.getIdMauSac());

            KichCo kichCo = new KichCo();
            kichCo.setId(sanPhamChiTietRequest.getIdKichCo());

            sanPhamChiTiet.setIdSanPham(sanPham);
            sanPhamChiTiet.setIdMauSac(mauSac);
            sanPhamChiTiet.setIdKichCo(kichCo);

            sanPhamChiTietRepository.save(sanPhamChiTiet);
            System.out.println("SanPhamChiTietService.update: " + sanPhamChiTiet.getId());
        }
    }

    public void delete(UUID id) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet != null) {
            sanPhamChiTietRepository.deleteById(id);
            System.out.println("SanPhamChiTietService.delete: " + id);
        }
    }
}
