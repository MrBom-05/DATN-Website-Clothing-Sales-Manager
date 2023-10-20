package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.SanPhamRequest;
import com.example.websitebanquanao.services.LoaiService;
import com.example.websitebanquanao.services.SanPhamService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller
@RequestMapping("/admin/san-pham")
public class SanPhamController {
    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private LoaiService loaiService;

    @Autowired
    private SanPhamRequest sanPhamRequest;

    private static final String redirect = "redirect:/admin/san-pham/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage) {
        model.addAttribute("sanPhamPage", sanPhamService.getPage(page, 5));
        model.addAttribute("listLoai", loaiService.getAll());
        model.addAttribute("sp", sanPhamRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("view", "/views/admin/san-pham/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id) {
        sanPhamService.delete(id);
        return redirect;
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("sp") SanPhamRequest sanPhamRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes, @RequestParam("anh") MultipartFile anh) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/san-pham/chi-tiet.jsp");
            return "admin/layout";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Thêm mới sản phẩm thành công");
        sanPhamService.add(sanPhamRequest, anh);
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("sp") SanPhamRequest sanPhamRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes, @RequestParam("anh") MultipartFile anh) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/san-pham/chi-tiet.jsp");
            return "admin/layout";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công");
        sanPhamService.update(sanPhamRequest, id, anh);
        return redirect;
    }
    @PostMapping("/them-nhanh")
    public String themNhanh(@Valid @ModelAttribute("sp") SanPhamRequest sanPhamRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes, @RequestParam("anh") MultipartFile anh) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/san-pham/chi-tiet.jsp");
            return "admin/layout";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Thêm mới sản phẩm thành công");
        sanPhamService.add(sanPhamRequest, anh);
        return "redirect:/admin/san-pham-chi-tiet/create";
    }

}
