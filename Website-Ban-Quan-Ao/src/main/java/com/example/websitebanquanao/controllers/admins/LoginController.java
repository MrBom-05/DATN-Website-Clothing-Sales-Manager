package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.KhuyenMai;
import com.example.websitebanquanao.infrastructures.requests.LoginAdminRequest;
import com.example.websitebanquanao.infrastructures.requests.NhanVienRequest;
import com.example.websitebanquanao.services.KhachHangService;
import com.example.websitebanquanao.services.KhuyenMaiService;
import com.example.websitebanquanao.services.NhanVienService;
import jakarta.servlet.http.HttpSession;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.sql.Date;
import java.time.Instant;

@Controller
public class LoginController {
    @Autowired
    private NhanVienService nhanVienService;
    @Autowired
    private HttpSession session;
    @Autowired
    private KhuyenMaiService khuyenMaiService;

    @GetMapping("/login-admin")
    public String login(Model model) {
        model.addAttribute("nv", new LoginAdminRequest());
        khuyenMaiService.checkNgayKetThuc();
        return "admin/login/login";
    }

    @PostMapping("/check-login-admin")
    public String checkLogin(@ModelAttribute("nv") LoginAdminRequest loginAdminRequest, Model model) {
        String email = loginAdminRequest.getEmail();
        String matKhau = loginAdminRequest.getMatKhau();
        NhanVienRequest nhanVienRequest = nhanVienService.checkLogin(email, matKhau);
        session.removeAttribute("error");

        if (email.trim().isEmpty() || matKhau.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            return "admin/login/login";
        }
        if (nhanVienRequest != null) {
            session.setAttribute("admin", nhanVienRequest);
            return "redirect:/admin";
        } else {
            session.setAttribute("error", "Email hoặc mật khẩu không đúng");
            return "admin/login/login";
        }
    }

    @GetMapping("/logout")
    public String logout() {
//        xoá toàn bộ session
        session.invalidate();


        return "redirect:/login-admin";
    }

}
