package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.*;
import com.example.websitebanquanao.infrastructures.requests.HoaDonRequest;
import com.example.websitebanquanao.infrastructures.requests.NhanVienRequest;
import com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse;
import com.example.websitebanquanao.infrastructures.responses.GioHangResponse;
import com.example.websitebanquanao.services.HoaDonChiTietService;
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
import java.util.List;
import java.util.UUID;


@Controller
@RequestMapping("/admin/ban-hang")
public class BanHangController {
    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;
    @Autowired
    private HoaDonService hoaDonService;
    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;
    @Autowired
    private SanPhamChiTietService ctspService;

    @Autowired
    HttpSession session;

    @GetMapping("")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "pageSize", defaultValue = "6") int pageSize, Model model) {
        Page<BanHangTaiQuayResponse> listProduct = sanPhamChiTietService.findAllCtsp(page, pageSize);
        model.addAttribute("listProduct", listProduct);
        model.addAttribute("listHoaDon", hoaDonService.getAll());
        model.addAttribute("hdct", new HoaDonChiTiet());
        return "admin/layoutbanhang";
    }

    @PostMapping("/add-hoa-don")
    public String addHoaDon(@ModelAttribute("hd") HoaDonRequest hoaDonRequest, @RequestParam("id") UUID id, Model model) {
        NhanVien nhanVien = new NhanVien();
        nhanVien.setId(id);
        System.out.println(nhanVien.getId());
        hoaDonRequest.setIdNhanVien(nhanVien);
        Instant currentInstant = Instant.now();
        LocalDate currentDate = LocalDate.now();
        hoaDonRequest.setNgayTao(currentDate);
        hoaDonRequest.setNgayThanhToan(currentInstant);
        hoaDonRequest.setTrangThai(0);
        hoaDonRequest.setLoaiHoaDon(0);
        hoaDonService.add(hoaDonRequest);
        return "redirect:/admin/ban-hang";
    }

    @PostMapping("/add-gio-hang/{idHoaDon}")
    public String addGioHang(@ModelAttribute("hdct") HoaDonChiTiet hoaDonChiTiet, @PathVariable("idHoaDon") UUID idHoaDon, @RequestParam("idSanPhamChiTiet") UUID idSanPhamChiTiet, @RequestParam("gia") int gia, @RequestParam("soLuongMoi") int soLuongMoi) {
        // Lấy chi tiết sản phẩm từ cơ sở dữ liệu dựa trên idSanPhamChiTiet
        SanPhamChiTiet ctsp = ctspService.findById(idSanPhamChiTiet);

        if (ctsp != null) {
            // Trừ đi số lượng mới từ số lượng hiện tại
            int soLuongConLai = ctsp.getSoLuong() - soLuongMoi;

            if (soLuongConLai < 0) {
                // Xử lý tình huống số lượng âm (tuỳ theo quy tắc của bạn)
                soLuongConLai = 0;
            }

            // Cập nhật số lượng mới
            ctsp.setSoLuong(soLuongConLai);
            ctspService.updateSoLuong(ctsp); // Đảm bảo bạn có một phương thức update trong ctspService
        }

        // Sử dụng trường soLuongMoi thay vì soLuong
        hoaDonChiTiet.setSoLuong(soLuongMoi);

        // Thêm sản phẩm vào giỏ hàng
        hoaDonChiTiet.setIdHoaDon(hoaDonService.getById(idHoaDon));
        hoaDonChiTietService.add(hoaDonChiTiet);

        return "redirect:/admin/ban-hang/view-hoa-don/" + idHoaDon;
    }


    @GetMapping("/view-hoa-don/{id}")
    public String viewHoaDon(@PathVariable("id") UUID id, @RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "pageSize", defaultValue = "6") int pageSize, Model model) {
        // Lấy thông tin hoá đơn chi tiết dựa trên id hoá đơn
        HoaDon hoaDon = hoaDonService.getById(id);

        // Lấy danh sách sản phẩm trong giỏ hàng (hoặc hoá đơn chi tiết)
        // Và set vào model để hiển thị trên trang JSP
        List<GioHangResponse> listSanPhamTrongGioHang = hoaDonChiTietService.getHoaDonChiTietByHoaDonId(id);

        // Truyền idHoaDon để sử dụng trong form
        Page<BanHangTaiQuayResponse> listProduct = sanPhamChiTietService.findAllCtsp(page, pageSize);
        model.addAttribute("listProduct", listProduct);
        model.addAttribute("listHoaDon", hoaDonService.getAll());
        model.addAttribute("idHoaDon", id);

        model.addAttribute("listSanPhamTrongGioHang", listSanPhamTrongGioHang);

        return "admin/layoutbanhang";
    }

    @PostMapping("/delete-gio-hang/{idHoaDonChiTiet}")
    public String deleteGioHang(
            @PathVariable("idHoaDonChiTiet") UUID idHoaDonChiTiet,
            @RequestParam("soLuong") int soLuong
    ) {
        // Lấy thông tin hoá đơn chi tiết dựa trên id
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietService.getById(idHoaDonChiTiet);
        // get so luong san pham chi tiet
        SanPhamChiTiet sanPhamChiTiet = ctspService.findById(hoaDonChiTiet.getIdSanPhamChiTiet().getId());
        Integer soLuongSanPhamChiTiet = sanPhamChiTiet.getSoLuong();

        if (hoaDonChiTiet != null) {
            // Kiểm tra và xử lý số lượng nhập
            if (soLuong > 0) {
                // Số lượng hiện tại của hoá đơn chi tiết
                int currentSoLuong = hoaDonChiTiet.getSoLuong();
                System.out.println("đây là số lượng hiện tại 1" + currentSoLuong);
                System.out.println("đây là số lượng 1" + soLuong);

                // Cập nhật số lượng sản phẩm chi tiết trước khi xoá
                ctspService.updateSoLuongAfterDelete(hoaDonChiTiet.getIdSanPhamChiTiet().getId(), soLuongSanPhamChiTiet + soLuong);

                if (soLuong >= currentSoLuong) {
                    System.out.println("đây là số lượng hiện tại 2" + currentSoLuong);
                    System.out.println("đây là số lượng 2" + soLuong);
                    // Nếu số lượng nhập lớn hơn hoặc bằng số lượng hiện tại, thì xoá hoá đơn chi tiết
                    hoaDonChiTietService.delete(idHoaDonChiTiet);
                } else {
                    // Nếu số lượng nhập nhỏ hơn số lượng hiện tại, thì cập nhật số lượng hoá đơn chi tiết
                    hoaDonChiTiet.setSoLuong(currentSoLuong - soLuong);
                    hoaDonChiTietService.update(hoaDonChiTiet);
                }
            }

            // Lấy id hoá đơn
            UUID idHoaDon = hoaDonChiTiet.getIdHoaDon().getId();

            // Chuyển hướng hoặc trả về trang hiển thị hoá đơn
            return "redirect:/admin/ban-hang/view-hoa-don/" + idHoaDon;
        }

        return "redirect:/admin/ban-hang";
    }
    @PostMapping("/thanh-toan/{idHoaDon}")
    public String thanhToan(@PathVariable("idHoaDon") UUID idHoaDon,@RequestParam("httt") Integer hinhThucThanhToan,@RequestParam("ghiChu") String ghiChu,Model model){
        HoaDon hoaDon = hoaDonService.getById(idHoaDon);

        if (hoaDon != null) {
            hoaDon.setTrangThai(1);
            hoaDon.setHinhThucThanhToan(hinhThucThanhToan);
            hoaDon.setGhiChu(ghiChu);
            hoaDonService.update(hoaDon, idHoaDon);
        }

        return "redirect:/admin/ban-hang/view-hoa-don/" + idHoaDon;
    }
}

