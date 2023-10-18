package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.KhuyenMaiRequest;
import com.example.websitebanquanao.infrastructures.responses.KhuyenMaiResponse;
import com.example.websitebanquanao.services.KhuyenMaiService;
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
@RequestMapping("/admin/khuyen-mai")
public class KhuyenMaiController {

    @Autowired
    private KhuyenMaiService khuyenMaiService;

    @Autowired
    private KhuyenMaiRequest khuyenMaiRequest;

    private static final String redirect = "redirect:/admin/khuyen-mai/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage) {
        Page<KhuyenMaiResponse> khuyenMaiPage = khuyenMaiService.getPage(page, 5);
        model.addAttribute("khuyenMaiPage", khuyenMaiPage);
        model.addAttribute("km", khuyenMaiRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes) {
        khuyenMaiService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá khuyến mãi thành công");
        return redirect;
    }

    @PostMapping("store")
    public String store(@ModelAttribute("km") KhuyenMaiRequest khuyenMaiRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
            return "admin/layout";
        }
        khuyenMaiService.add(khuyenMaiRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm khuyến mãi thành công");
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@ModelAttribute("km") KhuyenMaiRequest khuyenMaiRequest, @PathVariable("id") UUID id, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
            return "admin/layout";
        }
        khuyenMaiService.update(khuyenMaiRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khuyến mãi thành công");
        return redirect;
    }

    @GetMapping("update-trang-thai/{id}/{trangThai}")
    public String updateTrangThai(@PathVariable("id") UUID id, @PathVariable("trangThai") int trangThai, RedirectAttributes redirectAttributes) {
        khuyenMaiService.updateTrangThai(id, trangThai);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái khuyến mãi thành công");
        return redirect;
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<KhuyenMaiResponse> getKhuyenMai(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(khuyenMaiService.getById(id));
    }
}
