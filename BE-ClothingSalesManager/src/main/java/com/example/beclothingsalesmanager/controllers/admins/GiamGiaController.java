package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.GiamGiaRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.services.GiamGiaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/giam-gia")
public class GiamGiaController {
    @Autowired
    private GiamGiaService giamGiaService;

    @GetMapping("")
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok().body(giamGiaService.getAll());
    }

    @PostMapping("")
    public void add(@RequestBody GiamGiaRequest giamGiaRequest) {
        giamGiaService.add(giamGiaRequest);
    }

    @PutMapping("/{id}")
    public void update(@RequestBody GiamGiaRequest giamGiaRequest, @PathVariable("id") UUID id) {
        giamGiaService.update(giamGiaRequest, id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable UUID id) {
        giamGiaService.delete(id);
    }
}
