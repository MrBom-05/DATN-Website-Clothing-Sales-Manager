package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.KhachHangRequest;
import com.example.beclothingsalesmanager.services.KhachHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;


@RestController
@RequestMapping("/api/admin/khach-hang")
public class KhachHangController {
    @Autowired
    private KhachHangService khachHangService;

    @GetMapping
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok().body(khachHangService.getAll());
    }

    @PostMapping
    public void add(@RequestBody KhachHangRequest khachHangRequest) {
        khachHangService.add(khachHangRequest);
    }

    @PutMapping("/{id}")
    public void update(@RequestBody KhachHangRequest khachHangRequest, @PathVariable("id") UUID id) {
        khachHangService.update(khachHangRequest, id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable UUID id) {
        khachHangService.delete(id);
    }

}
