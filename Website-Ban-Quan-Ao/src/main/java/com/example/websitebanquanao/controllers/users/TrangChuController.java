package com.example.websitebanquanao.controllers.users;

import com.example.websitebanquanao.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.UUID;

@Controller
public class TrangChuController {

    @Autowired
    private LoaiService loaiService;

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private KichCoService kichCoService;

    @Autowired
    private AnhSanPhamService anhSanPhamService;

    @GetMapping("")
    public String trangChu(Model model) {
        model.addAttribute("listTrangChu", sanPhamService.getListTrangChu());
        model.addAttribute("viewBanner", "/views/user/banner.jsp");
        model.addAttribute("viewContent", "/views/user/trang-chu.jsp");
        return "user/layout";
    }

    @GetMapping("/san-pham")
    public String sanPham(Model model) {
        model.addAttribute("listLoai", loaiService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("viewContent", "/views/user/san-pham.jsp");
        return "user/layout";
    }

    @GetMapping("/san-pham/{idSanPham}/{idMauSac}")
    public String sanPhamChiTiet(@PathVariable("idSanPham") UUID idSanPham, @PathVariable("idMauSac") Integer idMauSac, Model model) {
        model.addAttribute("sanPham", sanPhamService.getByIdSanPham(idSanPham));
        model.addAttribute("listMauSac", mauSacService.getListMauSacByIdSanPham(idSanPham));
        model.addAttribute("listKichCo", kichCoService.getListKichCoByIdSanPhamAndMauSac(idSanPham, idMauSac));
        model.addAttribute("listAnh", anhSanPhamService.getListAnhByIdSanPhamAndIdMauSac(idSanPham, idMauSac));
        model.addAttribute("idMauSac", idMauSac);
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

    @GetMapping("/dang-nhap")
    public String dangNhap(Model model) {
        model.addAttribute("viewContent", "/views/user/dang-nhap.jsp");
        return "user/layout";
    }
}
