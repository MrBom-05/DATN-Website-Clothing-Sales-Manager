package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.KichCoRequest;
import com.example.websitebanquanao.infrastructures.requests.MauSacRequest;
import com.example.websitebanquanao.infrastructures.requests.SanPhamChiTietRequest;
import com.example.websitebanquanao.infrastructures.requests.SanPhamRequest;
import com.example.websitebanquanao.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

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

    @Autowired
    private AnhSanPhamService anhSanPhamService;
    @Autowired
    private MauSacRequest mauSacRequest;
    @Autowired
    private KichCoRequest kichCoRequest;
    @Autowired
    private LoaiService loaiService;
    @Autowired
    private SanPhamRequest sanPhamRequest;
    @GetMapping("/index")
    public String index(Model model) {
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/chi-tiet.jsp");
        return "admin/layout";
    }
    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("ms", mauSacRequest);
        model.addAttribute("kc",new KichCoRequest());
        model.addAttribute("listLoai", loaiService.getAll());
        model.addAttribute("sp", sanPhamRequest);

        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("action", "/admin/san-pham-chi-tiet/add");
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
        return "admin/layout";
    }
    @PostMapping("/add")
    public String add(@ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest) {
        sanPhamChiTietService.add(sanPhamChiTietRequest);
        return "redirect:/admin/san-pham-chi-tiet/index";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") SanPhamChiTiet sanPhamChiTiet, Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());

        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/edit.jsp");
        return "admin/layout";
    }
    @GetMapping("/get-anh/{id}")
    public String getAnh(@PathVariable("id") UUID id, Model model) {
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("listAnh", anhSanPhamService.getAll(id));
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
        return "admin/layout";
    }
}
