package com.example.websitebanquanao.controllers.users;

import com.example.websitebanquanao.infrastructures.requests.DangKyUserRequest;
import com.example.websitebanquanao.infrastructures.requests.DangNhapUserRequest;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.infrastructures.requests.KhachHangRequest;
import com.example.websitebanquanao.infrastructures.responses.KhachHangResponse;
import com.example.websitebanquanao.services.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
public class TrangChuController {

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
    private KhuyenMaiChiTietService khuyenMaiChiTietService;

    @Autowired
    private HttpSession session;

    // trang chủ
    @GetMapping("")
    public String trangChu(Model model) {
        model.addAttribute("listTrangChu", sanPhamService.getListTrangChu(""));
        model.addAttribute("viewBanner", "/views/user/banner.jsp");
        model.addAttribute("viewContent", "/views/user/trang-chu.jsp");
        return "user/layout";
    }

    // trang sản phẩm tất cả
    @GetMapping("/san-pham")
    public String sanPham(Model model, @RequestParam(defaultValue = "", name = "sort", required = false) String sort) {
        model.addAttribute("idLoai", -1);
        model.addAttribute("listLoai", sanPhamService.getListLoai());
        model.addAttribute("listSanPham", sanPhamService.getListTrangChu(sort));
        model.addAttribute("viewContent", "/views/user/san-pham.jsp");
        return "user/layout";
    }

    // trang sản phẩm theo loại
    @GetMapping("/san-pham/{idLoai}")
    public String sanPhamById(Model model, @PathVariable("idLoai") Integer idLoai, @RequestParam(defaultValue = "", name = "sort", required = false) String sort) {
        System.out.println("idLoai: " + idLoai);
        model.addAttribute("listLoai", sanPhamService.getListLoai());
        model.addAttribute("listSanPham", sanPhamService.getListSanPhamByIdLoai(idLoai, sort));
        model.addAttribute("idLoai", idLoai);
        model.addAttribute("viewContent", "/views/user/san-pham.jsp");
        return "user/layout";
    }

    // lấy số phần trăm khuyến mãi để hiển thị lên sản phẩm
    @GetMapping("/so-phan-tram-giam/{idSanPham}")
    @ResponseBody
    public ResponseEntity<Integer> soPhanTramGiam(@PathVariable("idSanPham") UUID idSanPham) {
        return ResponseEntity.ok(khuyenMaiChiTietService.getSoPhanTramGiamByIdSanPham(idSanPham));
    }

    // trang sản phẩm chi tiết
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

    // trang sản phẩm sale
    @GetMapping("/sale")
    public String sanPhamSale(Model model, @RequestParam(defaultValue = "", name = "sort", required = false) String sort) {
        model.addAttribute("listSanPham", sanPhamService.getListSale(sort));
        model.addAttribute("viewContent", "/views/user/khuyen-mai.jsp");
        return "user/layout";
    }

    @ModelAttribute("gioHang")
    public GioHangUserRequest taoGioHangUserRequest() {
        return new GioHangUserRequest();
    }

    // trang giỏ hàng
    @GetMapping("/gio-hang")
    public String gioHang(Model model) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            model.addAttribute("listGioHang", gioHangService.getListByIdKhachHang(khachHangResponse.getId()));
            model.addAttribute("tongTien", gioHangChiTietService.getTongTienByIdKhachHang(khachHangResponse.getId()));
        }
        model.addAttribute("viewContent", "/views/user/gio-hang.jsp");
        return "user/layout";
    }

    // thêm sản phẩm vào giả hàng trang chi tiết
    @PostMapping("/gio-hang/{id}")
    public String themGioHang(@ModelAttribute("gioHang") GioHangUserRequest gioHangUserRequest, Model model, @PathVariable("id") UUID id) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.add(id, khachHangResponse.getId(), gioHangUserRequest);
        return "redirect:/gio-hang";
    }

    // thay dổi số lượng sản phẩm trong giỏ hàng
    @PostMapping("/gio-hang/update/{id}")
    public String capNhatGioHang(@PathVariable("id") UUID id, @RequestParam("soLuong") Integer soLuong) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.updateByIdSanPhamChiTietAndIdKhachHang(id, khachHangResponse.getId(), soLuong);
        return "redirect:/gio-hang";
    }

    // xóa sản phẩm trong giỏ hàng
    @GetMapping("/gio-hang/{id}")
    public String xoaGioHang(@PathVariable("id") UUID id) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.deleteByIdSanPhamChiTietAndIdKhachHang(id, khachHangResponse.getId());
        return "redirect:/gio-hang";
    }

    // trang thanh toán
    @GetMapping("thanh-toan")
    public String thanhToan(Model model) {
        model.addAttribute("viewContent", "/views/user/thanh-toan.jsp");
        return "user/layout";
    }

    // trang đăng nhập
    @GetMapping("/dang-nhap")
    public String dangNhap(Model model) {
        model.addAttribute("dangNhap", new DangNhapUserRequest());
        model.addAttribute("dangKy", new DangKyUserRequest());
        model.addAttribute("viewContent", "/views/user/dang-nhap.jsp");
        return "user/layout";
    }

    // lấy form đăng nhập
    @PostMapping("/dang-nhap")
    public String dangNhap(@ModelAttribute("dangNhap") DangNhapUserRequest dangNhapUserRequest, Model model) {
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

    // lấy form đăng ký
    @PostMapping("/dang-ky")
    public String dangKy(@ModelAttribute("dangKy") DangKyUserRequest dangKyUserRequest, Model model) {
        String email = dangKyUserRequest.getEmailDK();
        String matKhau = dangKyUserRequest.getMatKhauDK();
        String hoTen = dangKyUserRequest.getHoTen();

        KhachHangRequest khachHangRequest = new KhachHangRequest();
        khachHangRequest.setEmail(email);
        khachHangRequest.setMatKhau(matKhau);
        khachHangRequest.setHoVaTen(hoTen);

        khachHangService.add(khachHangRequest);

        return "redirect:/dang-nhap";
    }

    // trang giới thiệu
    @GetMapping("/gioi-thieu")
    public String gioiThieu(Model model) {
        model.addAttribute("viewContent", "/views/user/gioi-thieu.jsp");
        return "user/layout";
    }

    // trang chính sách bảo mật
    @GetMapping("/chinh-sach-bao-mat")
    public String chinhSachBaoMat(Model model) {
        model.addAttribute("viewContent", "/views/user/chinh-sach-bao-mat.jsp");
        return "user/layout";
    }

    // trang chính sách đổi trả
    @GetMapping("/chinh-sach-doi-tra")
    public String chinhSachDoiTra(Model model) {
        model.addAttribute("viewContent", "/views/user/chinh-sach-doi-tra.jsp");
        return "user/layout";
    }
}
