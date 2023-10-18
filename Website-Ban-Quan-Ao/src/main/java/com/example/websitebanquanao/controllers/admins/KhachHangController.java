package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.KhachHangRequest;
import com.example.websitebanquanao.infrastructures.responses.KhachHangResponse;
import com.example.websitebanquanao.services.KhachHangService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller
@RequestMapping("/admin/khach-hang")
public class KhachHangController {
    @Autowired
    private KhachHangService khachHangService;

    @Autowired
    private KhachHangRequest khachHangRequest;

    private static final String redirect = "redirect:/admin/khach-hang/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage) {
        Page<KhachHangResponse> khachHangPage = khachHangService.getPage(page, 5);
        model.addAttribute("khachHangPage", khachHangPage);
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("view", "/views/admin/khach-hang/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes) {
        khachHangService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá khách hàng thành công");
        return redirect;
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("kh") KhachHangRequest khachHangRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khach-hang/index.jsp");
            return "admin/layout";
        }
        khachHangService.add(khachHangRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm khách hàng thành công");
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("kh") KhachHangRequest khachHangRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khach-hang/index.jsp");
            return "admin/layout";
        }
        khachHangService.update(khachHangRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khách hàng thành công");
        return redirect;
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<KhachHangResponse> getKhachHang(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(khachHangService.getById(id));
    }
}
