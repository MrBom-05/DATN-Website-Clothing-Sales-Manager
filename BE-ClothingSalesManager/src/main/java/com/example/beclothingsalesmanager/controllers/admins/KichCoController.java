package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.KichCoRequest;
import com.example.beclothingsalesmanager.infrastructures.requests.MauSacRequest;
import com.example.beclothingsalesmanager.services.KichCoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/kich-co")
public class KichCoController {
    @Autowired
    private KichCoService kichCoService;

    @GetMapping
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok().body(kichCoService.getAll());
    }

    @PostMapping
    public void add(@RequestBody KichCoRequest kichCoRequest) {
        kichCoService.add(kichCoRequest);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        kichCoService.delete(id);
    }

}
