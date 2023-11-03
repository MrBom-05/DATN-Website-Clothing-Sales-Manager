package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.services.HoaDonChiTietService;
import com.example.websitebanquanao.services.HoaDonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/view/spct")
public class HoaDonRestController {
    @Autowired
    private HoaDonService hoaDonService;
    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;
    // getlist sản phẩm by id giỏ hàng
    @GetMapping("/view/{id}")
    public List<GioHangResponse> viewHoaDon(@PathVariable("id") UUID id) {
        return hoaDonChiTietService.getHoaDonChiTietByHoaDonId(id);
    }

}
