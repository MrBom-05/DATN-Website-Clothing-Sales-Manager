package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.SanPhamRequest;
import com.example.beclothingsalesmanager.services.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/san-pham")
public class SanPhamController {
    @Autowired
    private SanPhamService sanPhamService;

    @GetMapping("")
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok(sanPhamService.getAll());
    }

    @PostMapping("")
    public void add(@RequestBody SanPhamRequest sanPhamRequest) {
        sanPhamService.add(sanPhamRequest);
        System.out.println("Thêm thành công " + sanPhamRequest.getTen());
    }

    @PutMapping("/{id}")
    public void update(@RequestBody SanPhamRequest sanPhamRequest, @PathVariable("id") UUID id) {
        sanPhamService.update(sanPhamRequest, id);
        System.out.println("Cập nhật thành công " + sanPhamRequest.getTen());
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") UUID id) {
        sanPhamService.delete(id);
        System.out.println("Xóa thành công " + id);
    }
}
