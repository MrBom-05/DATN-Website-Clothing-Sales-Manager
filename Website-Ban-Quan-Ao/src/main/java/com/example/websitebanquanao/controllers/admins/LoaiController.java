package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.Loai;
import com.example.websitebanquanao.infrastructures.requests.LoaiRequest;
import com.example.websitebanquanao.services.LoaiService;
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

@Controller
@RequestMapping("/admin/loai")
public class LoaiController {
    @Autowired
    private LoaiService loaiService;

    @Autowired
    private LoaiRequest loaiRequest;

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page,
                        Model model,
                        @ModelAttribute("successMessage") String successMessage){

        Page<Loai> loaiPage = loaiService.getAllWithPagination(page, 5);
        model.addAttribute("loaiPage", loaiPage);
        model.addAttribute("list", loaiService.getAll());
        model.addAttribute("l", loaiRequest);
        model.addAttribute("view", "/views/admin/loai/index.jsp");
        model.addAttribute("successMessage", successMessage);
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes){
        loaiService.delete(id);
        // Lưu thông báo xoá thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Xoá loại thành công");
        return "redirect:/admin/loai/index"; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("store")
    public String store(
            @Valid @ModelAttribute("l") LoaiRequest loaiRequest, BindingResult result,
            Model model, RedirectAttributes redirectAttributes
    )
    {
        if(loaiRequest.getTen().trim().isEmpty()){
            result.rejectValue("ten", "error.l", "Tên Loại không được để trống");
            return "admin/layout";
        }
        if (result.hasErrors()) {
            model.addAttribute("list", loaiService.getAll());
            model.addAttribute("view", "/views/admin/loai/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        loaiService.add(loaiRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm loại thành công");
        return "redirect:/admin/loai/index"; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") Integer id,
                         @Valid @ModelAttribute("l") LoaiRequest loaiRequest, BindingResult result,
                         Model model, RedirectAttributes redirectAttributes
    )
    {
        if (result.hasErrors()) {
            model.addAttribute("list", loaiService.getAll());
            model.addAttribute("view", "/views/admin/loai/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        loaiService.update(loaiRequest,id);
        // Lưu thông báo cập nhật thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật loại thành công");
        return "redirect:/admin/loai/index"; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }
    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<Loai> getLoai(@PathVariable("id") Integer id) {
        Loai l = loaiService.findById(id);
        return ResponseEntity.ok(l);
    }
}
