package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.SanPhamChiTietRequest;
import com.example.websitebanquanao.services.KichCoService;
import com.example.websitebanquanao.services.MauSacService;
import com.example.websitebanquanao.services.SanPhamChiTietService;
import com.example.websitebanquanao.services.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/san-pham-chi-tiet")
public class SanPhamChiTietController {

    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private KichCoService kichCoService;

    @GetMapping("")
    public String index(Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());

        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }
}
