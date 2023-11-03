package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.responses.AnhSanPhamResponse;
import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.infrastructures.responses.KhachHangResponse;
import com.example.websitebanquanao.services.HoaDonChiTietService;
import com.example.websitebanquanao.services.HoaDonService;
import com.example.websitebanquanao.services.KhachHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.websitebanquanao.services.AnhSanPhamService;
import java.util.List;
import java.util.UUID;

@org.springframework.web.bind.annotation.RestController
public class RestController {
    @Autowired
    private HoaDonService hoaDonService;
    @Autowired
    private KhachHangService KhachHangService;
    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;
    @Autowired
    private AnhSanPhamService anhSanPhamService;
    // getlist sản phẩm by id giỏ hàng
    @GetMapping("/view/spct/view/{id}")
    public List<GioHangResponse> viewHoaDon(@PathVariable("id") UUID id) {
        return hoaDonChiTietService.getHoaDonChiTietByHoaDonId(id);
    }
    @GetMapping("/view/thong-tin-khach-hang")
    public List<KhachHangResponse> viewKhachHang() {
        return KhachHangService.getAll();
    }

    @GetMapping("/get-anh-san-pham/{idCtsp}")
    @ResponseBody
    public List<AnhSanPhamResponse> getAnhSanPhamByCtspId(@PathVariable("idCtsp") UUID idCtsp) {
        List<AnhSanPhamResponse> listAnh = anhSanPhamService.getListAnhByIdSanPhamChiTiet(idCtsp);
        return listAnh;
    }

}
