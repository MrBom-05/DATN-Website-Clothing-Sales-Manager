package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.services.HoaDonChiTietService;
import com.example.websitebanquanao.services.HoaDonService;
import com.example.websitebanquanao.services.SanPhamChiTietService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/view/hoa-don")
public class HoaDonRestController {
    @Autowired
    private HoaDonService hoaDonService;
    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;
    @GetMapping("/getCartTable/{id}")
    @ResponseBody
    public List<GioHangResponse> getCartTable(@PathVariable("id") UUID id) {
        List<GioHangResponse> list = hoaDonChiTietService.getHoaDonChiTietByHoaDonId(id);
        System.out.println("list: " + list);
        return list;
    }
}
