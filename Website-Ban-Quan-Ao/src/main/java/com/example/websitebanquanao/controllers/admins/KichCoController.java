package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.KichCo;
import com.example.websitebanquanao.infrastructures.requests.KichCoRequest;
import com.example.websitebanquanao.infrastructures.responses.KichCoResponse;
import com.example.websitebanquanao.services.KichCoService;
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
@RequestMapping("/admin/kich-co")
public class KichCoController {
    @Autowired
    private KichCoService kichCoService;

    @Autowired
    private KichCoRequest kichCoRequest;

    private static final String redirect = "redirect:/admin/kich-co/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage) {
        Page<KichCoResponse> kichCoPage = kichCoService.getPage(page, 5);
        model.addAttribute("kichCoPage", kichCoPage);
        model.addAttribute("kc", kichCoRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("view", "/views/admin/kich-co/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        kichCoService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá kích cỡ thành công");
        return redirect;
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("kc") KichCoRequest kichCoRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/kich-co/index.jsp");
            return "admin/layout";
        }
        kichCoService.add(kichCoRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm kích cỡ thành công");
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, @Valid @ModelAttribute("l") KichCoRequest kichCoRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/kich-co/index.jsp");
            return "admin/layout";
        }
        kichCoService.update(kichCoRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật kích cỡ thành công");
        return redirect;
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<KichCoResponse> getLoai(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(kichCoService.getById(id));
    }
    @PostMapping("/them-nhanh")
    public String themNhanh(@Valid @ModelAttribute("kc") KichCoRequest kichCoRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/kich-co/index.jsp");
            return "admin/layout";
        }
        kichCoService.add(kichCoRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm kích cỡ thành công");
        return "redirect:/admin/san-pham-chi-tiet/create";
    }
}
