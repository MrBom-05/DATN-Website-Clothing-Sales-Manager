package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.SanPhamChiTietRequest;
import com.example.beclothingsalesmanager.services.SanPhamChiTietService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/san-pham-chi-tiet")
public class SanPhamChiTietController {
    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @GetMapping()
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok(sanPhamChiTietService.getAll());
    }

    @PostMapping()
    public void add(@RequestBody SanPhamChiTietRequest sanPhamChiTietRequest) {
        sanPhamChiTietService.add(sanPhamChiTietRequest);
    }

    @PutMapping("/{id}")
    public void update(@RequestBody SanPhamChiTietRequest sanPhamChiTietRequest, @PathVariable("id") UUID id) {
        sanPhamChiTietService.update(sanPhamChiTietRequest, id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") UUID id) {
        sanPhamChiTietService.delete(id);
    }
}
