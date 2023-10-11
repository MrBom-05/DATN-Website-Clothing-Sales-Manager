package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.GiamGiaRequest;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import com.example.websitebanquanao.services.GiamGiaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller
@RequestMapping("/admin/giam-gia")
public class GiamGiaController {
    @Autowired
    private GiamGiaService giamGiaService;
    @Autowired
    private GiamGiaRequest giamGiaRequest;

    private static final String redirect = "redirect:/admin/giam-gia/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage) {
        Page<GiamGiaResponse> giamGiaPage = giamGiaService.getPage(page, 5);
        model.addAttribute("giamGiaPage", giamGiaPage);
        model.addAttribute("gg", giamGiaRequest);
        model.addAttribute("successMessage", successMessage); // Hiển thị thông báo thành công
        model.addAttribute("view", "/views/admin/giam-gia/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes) {
        giamGiaService.delete(id);
        // Lưu thông báo xoá thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Xoá giảm giá thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("gg") GiamGiaRequest giamGiaRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/giam-gia/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        giamGiaService.add(giamGiaRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm giảm giá thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("gg") GiamGiaRequest giamGiaRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/giam-gia/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        giamGiaService.update(giamGiaRequest, id);
        // Lưu thông báo cập nhật thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật giảm giá thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<GiamGiaResponse> getGiamGia(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(giamGiaService.getById(id));
    }

}