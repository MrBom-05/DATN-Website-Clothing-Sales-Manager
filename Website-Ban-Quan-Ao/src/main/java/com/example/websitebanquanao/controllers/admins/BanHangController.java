package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.KhachHang;
import com.example.websitebanquanao.entities.NhanVien;
import com.example.websitebanquanao.infrastructures.requests.HoaDonRequest;
import com.example.websitebanquanao.infrastructures.requests.NhanVienRequest;
import com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse;
import com.example.websitebanquanao.services.HoaDonService;
import com.example.websitebanquanao.services.SanPhamChiTietService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Controller
@RequestMapping("/admin/ban-hang")
public class BanHangController {
    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;
    @Autowired
    private HoaDonService hoaDonService;
    @Autowired
    HttpSession session;
    @GetMapping("")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "pageSize", defaultValue = "12") int pageSize, Model model) {
        Page<BanHangTaiQuayResponse> listProduct = sanPhamChiTietService.findAllCtsp(page, pageSize);
        model.addAttribute("listProduct", listProduct);
        return "admin/layoutbanhang";
    }
    @PostMapping("/add-hoa-don")
    public String addHoaDon(@ModelAttribute("hd") HoaDonRequest hoaDonRequest, Model model){;
        Instant currentInstant = Instant.now();
        hoaDonRequest.setNgayTao(currentInstant);
        hoaDonRequest.setNgayThanhToan(currentInstant);
        hoaDonRequest.setTrangThai(0);
        hoaDonService.add(hoaDonRequest);
        return "redirect:/admin/ban-hang";
    }
}
