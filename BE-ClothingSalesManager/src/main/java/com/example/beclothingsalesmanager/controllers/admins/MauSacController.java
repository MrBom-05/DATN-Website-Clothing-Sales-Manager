package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.MauSacRequest;
import com.example.beclothingsalesmanager.services.MauSacService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/mau-sac")
public class MauSacController {
    @Autowired
    private MauSacService mauSacService;

    @GetMapping
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok().body(mauSacService.getAll());
    }

    @PostMapping
    public void add(@RequestBody MauSacRequest mauSacRequest) {
        mauSacService.add(mauSacRequest);
        System.out.println("Thêm thành công " + mauSacRequest.getTen());
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        mauSacService.delete(id);
        System.out.println("Xoá thành công " + id);
    }

}
