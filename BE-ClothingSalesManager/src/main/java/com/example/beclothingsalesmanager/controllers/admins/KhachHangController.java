package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.responses.KhachHangReponse;
import com.example.beclothingsalesmanager.services.KhachHangService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;


@RestController
@RequestMapping("/admin/khach-hang")
public class KhachHangController {
    @Autowired
    private KhachHangService khachHangService;

    @GetMapping
    public ResponseEntity<?> findPage(@RequestParam(defaultValue = "0", name = "page") int page){
        Page<KhachHangReponse> khachHangReponses = khachHangService.findAllPage(page);
        return ResponseEntity.ok().body(khachHangReponses.getContent());
    }

    @PostMapping
    public ResponseEntity<?> add(@Valid @RequestBody KhachHangReponse khachHangReponse, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            khachHangService.add(khachHangReponse);
            return ResponseEntity.ok().body("Thêm thành công");
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @RequestBody KhachHangReponse khachHangReponse, BindingResult bindingResult, @PathVariable("id") UUID id) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            khachHangService.update(khachHangReponse, id);
            return ResponseEntity.ok().body("Sửa thành công");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id) {
        khachHangService.delete(id);
        return ResponseEntity.ok().body("Xóa thành công");
    }

}
