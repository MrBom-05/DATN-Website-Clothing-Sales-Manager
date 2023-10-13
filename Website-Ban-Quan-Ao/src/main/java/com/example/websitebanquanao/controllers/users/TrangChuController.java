package com.example.websitebanquanao.controllers.users;

import com.example.websitebanquanao.infrastructures.requests.DangNhapUserRequest;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.infrastructures.responses.KhachHangResponse;
import com.example.websitebanquanao.services.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

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

    @Autowired
    private KhachHangService khachHangService;

    @Autowired
    private GioHangService gioHangService;

    @Autowired
    private GioHangChiTietService gioHangChiTietService;

    @Autowired
    private HttpSession session;

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

    @ModelAttribute("gioHang")
    public GioHangUserRequest taoGioHangUserRequest() {
        return new GioHangUserRequest();
    }

    @GetMapping("/gio-hang")
    public String gioHang(Model model) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            model.addAttribute("listGioHang", gioHangService.getListByIdKhachHang(khachHangResponse.getId()));
        }
        model.addAttribute("viewContent", "/views/user/gio-hang.jsp");
        return "user/layout";
    }

    @PostMapping("/gio-hang/{id}")
    public String themGioHang(@ModelAttribute("gioHang") GioHangUserRequest gioHangUserRequest, Model model, @PathVariable("id") UUID id) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.add(id, khachHangResponse.getId(), gioHangUserRequest);
        return "redirect:/gio-hang";
    }

    @GetMapping("/gio-hang/{id}")
    public String xoaGioHang(@PathVariable("id") UUID id) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.deleteByIdSanPhamChiTietAndIdKhachHang(id, khachHangResponse.getId());
        return "redirect:/gio-hang";
    }

    @GetMapping("thanh-toan")
    public String thanhToan(Model model) {
        model.addAttribute("viewContent", "/views/user/thanh-toan.jsp");
        return "user/layout";
    }

    @GetMapping("/dang-nhap")
    public String dangNhap(Model model) {
        model.addAttribute("kh", new DangNhapUserRequest());
        model.addAttribute("viewContent", "/views/user/dang-nhap.jsp");
        return "user/layout";
    }

    @PostMapping("/dang-nhap")
    public String dangNhap(@ModelAttribute("kh") DangNhapUserRequest dangNhapUserRequest, Model model) {
        String email = dangNhapUserRequest.getEmail();
        String matKhau = dangNhapUserRequest.getMatKhau();

        KhachHangResponse khachHangResponse = khachHangService.getByEmailAndMatKhau(email, matKhau);
        if (khachHangResponse != null) {
            session.setAttribute("khachHang", khachHangResponse);
            gioHangService.checkAndAdd(khachHangResponse.getId());
            return "redirect:/";
        }
        return "redirect:/dang-nhap";
    }
}
