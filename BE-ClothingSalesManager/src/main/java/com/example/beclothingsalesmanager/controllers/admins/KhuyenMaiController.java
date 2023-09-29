package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.infrastructures.responses.KhuyenMaiResponse;
import com.example.beclothingsalesmanager.services.GiamGiaService;
import com.example.beclothingsalesmanager.services.KhuyenMaiService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/khuyen-mai")
public class KhuyenMaiController {
    @Autowired
    private KhuyenMaiService khuyenMaiService;

    @GetMapping("/phan-trang")
    public ResponseEntity<?> findPage(@RequestParam(defaultValue = "0", name = "page") int page) {
        Page<KhuyenMaiResponse> khuyenMaiResponses = khuyenMaiService.findAllPage(page);
        return ResponseEntity.ok().body(khuyenMaiResponses.getContent());
    }

    //
    @PostMapping("")
    public ResponseEntity<?> add(@Valid @RequestBody KhuyenMaiResponse khuyenMaiResponse, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            khuyenMaiService.add(khuyenMaiResponse);
            return ResponseEntity.ok().body("Thêm thành công");
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @RequestBody KhuyenMaiResponse khuyenMaiResponse, BindingResult bindingResult, @PathVariable("id") UUID id) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            khuyenMaiService.update(khuyenMaiResponse, id);
            return ResponseEntity.ok().body("Sửa thành công");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id) {
        khuyenMaiService.delete(id);
        return ResponseEntity.ok().body("Xóa thành công");
    }
}
