package com.example.websitebanquanao.controllers.users;

import com.example.websitebanquanao.services.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TrangChuController {

    @Autowired
    private SanPhamService sanPhamService;

    @GetMapping("")
    public String trangChu(Model model) {
        model.addAttribute("listTrangChu", sanPhamService.getListTrangChu());
        model.addAttribute("viewBanner", "/views/user/banner.jsp");
        model.addAttribute("viewContent", "/views/user/trang-chu.jsp");
        return "user/layout";
    }

    @GetMapping("/san-pham")
    public String sanPham(Model model) {
        model.addAttribute("viewContent", "/views/user/san-pham.jsp");
        return "user/layout";
    }

    @GetMapping("/san-pham/{id}")
    public String sanPhamChiTiet(Model model) {
        model.addAttribute("viewContent", "/views/user/san-pham-chi-tiet.jsp");
        return "user/layout";
    }

    @GetMapping("/gio-hang")
    public String gioHang(Model model) {
        model.addAttribute("viewContent", "/views/user/gio-hang.jsp");
        return "user/layout";
    }

    @GetMapping("thanh-toan")
    public String thanhToan(Model model) {
        model.addAttribute("viewContent", "/views/user/thanh-toan.jsp");
        return "user/layout";
    }
}
