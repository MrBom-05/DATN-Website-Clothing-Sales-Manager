package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.GiamGiaRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.services.GiamGiaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/admin/giam-gia")
public class GiamGiaController {
    @Autowired
    private GiamGiaService giamGiaService;

    @GetMapping("/phan-trang")
    public ResponseEntity<?> findPage(@RequestParam(defaultValue = "0", name = "page") int page) {
        Page<GiamGiaResponse> giamGiaReponses = giamGiaService.findAllPage(page);
        return ResponseEntity.ok().body(giamGiaReponses.getContent());
    }

    //
    @PostMapping("")
    public ResponseEntity<?> add(@Valid @RequestBody GiamGiaResponse giamGiaResponse, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            giamGiaService.add(giamGiaResponse);
            return ResponseEntity.ok().body("Thêm thành công");
        }
    }
    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @RequestBody GiamGiaResponse giamGiaResponse, BindingResult bindingResult, @PathVariable("id") UUID id) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            giamGiaService.update(giamGiaResponse, id);
            return ResponseEntity.ok().body("Sửa thành công");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id) {
        giamGiaService.delete(id);
        return ResponseEntity.ok().body("Xóa thành công");
    }
}
