package com.example.websitebanquanao.controllers.users;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.infrastructures.requests.*;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import com.example.websitebanquanao.infrastructures.responses.KhachHangResponse;
import com.example.websitebanquanao.services.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
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
    private GiamGiaService giamGiaService;

    @Autowired
    private HoaDonService hoaDonService;

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
    public String gioHang(Model model, @ModelAttribute("thongBaoGiamGia") String thoangBaoGiamGia) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        GiamGiaResponse giamGiaResponse = (GiamGiaResponse) session.getAttribute("giamGia");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            BigDecimal tongTien = gioHangChiTietService.getTongTienByIdKhachHang(khachHangResponse.getId());
            model.addAttribute("listGioHang", gioHangService.getListByIdKhachHang(khachHangResponse.getId()));
            model.addAttribute("tongTien", tongTien);
            if (giamGiaResponse != null) {
                int soPhanTramGiam = giamGiaResponse.getSoPhanTramGiam();
                BigDecimal soTienDuocGiam = tongTien.multiply(new BigDecimal(soPhanTramGiam).divide(new BigDecimal(100)));
                BigDecimal soTienSauKhiGiam = tongTien.subtract(soTienDuocGiam);
                model.addAttribute("soTienDuocGiam", soTienDuocGiam);
                model.addAttribute("soTienSauKhiGiam", soTienSauKhiGiam);
                model.addAttribute("thongBaoGiamGia", thoangBaoGiamGia);
            } else {
                model.addAttribute("soTienDuocGiam", 0);
                model.addAttribute("soTienSauKhiGiam", tongTien);
                model.addAttribute("thongBaoGiamGia", "");
            }
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

    // add voucher
    @PostMapping("/ap-dung-voucher")
    public String apDungVoucher(@RequestParam("ma") String ma, RedirectAttributes redirectAttributes) {
        GiamGiaResponse giamGiaResponse = giamGiaService.findByMa(ma);
        session.setAttribute("giamGia", giamGiaResponse);
        redirectAttributes.addFlashAttribute("thongBaoGiamGia", "Đã áp dụng mã giảm giá.");
        return "redirect:/gio-hang";
    }

    // trang thanh toán
    @GetMapping("thanh-toan")
    public String thanhToan(Model model) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        GiamGiaResponse giamGiaResponse = (GiamGiaResponse) session.getAttribute("giamGia");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            BigDecimal tongTien = gioHangChiTietService.getTongTienByIdKhachHang(khachHangResponse.getId());
            model.addAttribute("listGioHang", gioHangService.getListByIdKhachHang(khachHangResponse.getId()));
            model.addAttribute("tongTien", tongTien);
            if (giamGiaResponse != null) {
                int soPhanTramGiam = giamGiaResponse.getSoPhanTramGiam();
                BigDecimal soTienDuocGiam = tongTien.multiply(new BigDecimal(soPhanTramGiam).divide(new BigDecimal(100)));
                BigDecimal soTienSauKhiGiam = tongTien.subtract(soTienDuocGiam);
                model.addAttribute("soTienDuocGiam", soTienDuocGiam);
                model.addAttribute("soTienSauKhiGiam", soTienSauKhiGiam);
            } else {
                model.addAttribute("soTienDuocGiam", 0);
                model.addAttribute("soTienSauKhiGiam", tongTien);
            }
        }
        model.addAttribute("viewContent", "/views/user/thanh-toan.jsp");
        return "user/layout";
    }

    @ModelAttribute("formThanhToan")
    public FormThanhToan formThanhToan() {
        return new FormThanhToan();
    }

    // form thanh toán
    @PostMapping("thanh-toan")
    public String formThanhToan(@ModelAttribute("formThanhToan") FormThanhToan formThanhToan, Model model) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        GiamGiaResponse giamGiaResponse = (GiamGiaResponse) session.getAttribute("giamGia");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            if (giamGiaResponse == null) {
                String maHoaDon = hoaDonService.addHoaDonUser(formThanhToan, khachHangResponse, null);
                model.addAttribute("maHoaDon", maHoaDon);
            } else {
                String maHoaDon = hoaDonService.addHoaDonUser(formThanhToan, khachHangResponse, giamGiaResponse);
                model.addAttribute("maHoaDon", maHoaDon);
                session.setAttribute("giamGia", null);
            }
            model.addAttribute("viewContent", "/views/user/hoan-thanh-thanh-toan.jsp");
        }
        return "user/layout";
    }

    // trang đăng nhập
    @GetMapping("/dang-nhap")
    public String dangNhap(Model model, @ModelAttribute("loginError") String loginError) {
        model.addAttribute("dangNhap", new DangNhapUserRequest());
        model.addAttribute("dangKy", new DangKyUserRequest());
        model.addAttribute("loginError", loginError);
        model.addAttribute("viewContent", "/views/user/dang-nhap.jsp");
        return "user/layout";
    }

    // lấy form đăng nhập
    @PostMapping("/dang-nhap")
    public String dangNhap(@ModelAttribute("dangNhap") DangNhapUserRequest dangNhapUserRequest, RedirectAttributes redirectAttributes) {
        String email = dangNhapUserRequest.getEmail();
        String matKhau = dangNhapUserRequest.getMatKhau();

        if (email == null || email.isEmpty() || matKhau == null || matKhau.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin.");
            return "redirect:/dang-nhap";
        }

        KhachHangResponse khachHangResponse = khachHangService.getByEmailAndMatKhau(email, matKhau);

        if (khachHangResponse != null) {
            session.setAttribute("khachHang", khachHangResponse);
            gioHangService.checkAndAdd(khachHangResponse.getId());
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng.");
            return "redirect:/dang-nhap";
        }
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
