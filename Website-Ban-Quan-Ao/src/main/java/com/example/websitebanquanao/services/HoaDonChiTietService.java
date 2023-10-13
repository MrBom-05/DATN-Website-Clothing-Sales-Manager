package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.HoaDonChiTiet;
import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.repositories.HoaDonChiTietRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class HoaDonChiTietService {
@Autowired
private HoaDonChiTietRepository hoaDonChiTietRepository;
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
        }else{
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
}
