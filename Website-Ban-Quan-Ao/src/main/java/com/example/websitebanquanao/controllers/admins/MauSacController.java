package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.MauSac;
import com.example.websitebanquanao.infrastructures.requests.MauSacRequest;
import com.example.websitebanquanao.services.MauSacService;
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
@RequestMapping("/admin/mau-sac")
public class MauSacController {
    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private MauSacRequest mauSacRequest;

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page,
                        Model model,
                        @ModelAttribute("successMessage") String successMessage){
        Page<MauSac> mauSacPage = mauSacService.getAllWithPagination(page, 5);
        model.addAttribute("mauSacPage", mauSacPage);

        model.addAttribute("list", mauSacService.getAll());
        model.addAttribute("ms", mauSacRequest);
        model.addAttribute("view", "/views/admin/mau-sac/index.jsp");
        model.addAttribute("successMessage", successMessage);
        return "admin/layout";
    }
    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes){
        mauSacService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá màu sắc thành công");
        return "redirect:/admin/mau-sac/index";
    }

    @PostMapping("store")
    public String store(
            @Valid @ModelAttribute("ms") MauSacRequest mauSacRequest, BindingResult result,
            Model model, RedirectAttributes redirectAttributes
    )
    {
        if(mauSacRequest.getMaMauSac().trim().isEmpty()){
            result.rejectValue("maMauSac", "error.ms", "Mã màu không được để trống");
            return "admin/layout";
        }
        if (result.hasErrors()) {
            model.addAttribute("list", mauSacService.getAll());
            model.addAttribute("view", "/views/admin/mau-sac/index.jsp");
            return "admin/layout";
        }
        mauSacService.add(mauSacRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm màu sắc thành công");
        return "redirect:/admin/mau-sac/index";
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") Integer id,
                         @Valid @ModelAttribute("ms") MauSacRequest mauSacRequest, BindingResult result,
                         Model model, RedirectAttributes redirectAttributes
    )
    {
        if (result.hasErrors()) {
            model.addAttribute("list", mauSacService.getAll());
            model.addAttribute("view", "/views/admin/mau-sac/index.jsp");
            return "admin/layout";
        }
        mauSacService.update(mauSacRequest,id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật màu sắc thành công");
        return "redirect:/admin/mau-sac/index";
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<MauSac> getMauSac(@PathVariable("id") Integer id) {
        MauSac ms = mauSacService.findById(id);
        return ResponseEntity.ok(ms);
    }
}
