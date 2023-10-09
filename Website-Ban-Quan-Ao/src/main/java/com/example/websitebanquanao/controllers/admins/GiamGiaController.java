package com.example.websitebanquanao.controllers.admins;
import com.example.websitebanquanao.entities.GiamGia;
import com.example.websitebanquanao.infrastructures.requests.GiamGiaRequest;
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

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page,
                        Model model,
                        @ModelAttribute("successMessage") String successMessage){

        Page<GiamGia> giamGiaPage = giamGiaService.getAllWithPagination(page, 5);
        model.addAttribute("giamGiaPage", giamGiaPage);
        model.addAttribute("list", giamGiaService.getAll());
        model.addAttribute("gg", giamGiaRequest);
        model.addAttribute("view", "/views/admin/giam-gia/index.jsp");
        model.addAttribute("successMessage", successMessage); // Hiển thị thông báo thành công
        return "admin/layout";
    }
    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes){
        giamGiaService.delete(id);
        // Lưu thông báo xoá thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Xoá giảm giá thành công");
        return "redirect:/admin/giam-gia/index"; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("store")
    public String store(
            @Valid @ModelAttribute("gg") GiamGiaRequest giamGiaRequest, BindingResult result,
            Model model, RedirectAttributes redirectAttributes
    )
    {
        if (result.hasErrors()) {
            model.addAttribute("list", giamGiaService.getAll());
            model.addAttribute("view", "/views/admin/giam-gia/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        giamGiaService.add(giamGiaRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm giảm giá thành công");
        return "redirect:/admin/giam-gia/index"; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("update/{id}")
    public String update(
            @PathVariable("id") UUID id,
            @Valid @ModelAttribute("gg") GiamGiaRequest giamGiaRequest, BindingResult result,
            Model model, RedirectAttributes redirectAttributes
    )
    {
        if (result.hasErrors()) {
            model.addAttribute("list", giamGiaService.getAll());
            model.addAttribute("view", "/views/admin/giam-gia/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        giamGiaService.update(giamGiaRequest,id);
        // Lưu thông báo cập nhật thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật giảm giá thành công");
        return "redirect:/admin/giam-gia/index"; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<GiamGia> getGiamGia(@PathVariable("id") UUID id) {
        GiamGia giamGia = giamGiaService.findById(id);
        return ResponseEntity.ok(giamGia);
    }

}
