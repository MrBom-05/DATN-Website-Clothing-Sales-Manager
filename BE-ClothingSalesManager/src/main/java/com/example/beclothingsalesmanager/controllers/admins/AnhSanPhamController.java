package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.services.AnhSanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/anh-san-pham")
public class AnhSanPhamController {
    @Autowired
    private AnhSanPhamService anhSanPhamService;

    @GetMapping("/{id}")
    public ResponseEntity<?> getAll(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(anhSanPhamService.getAll(id));
    }
}
