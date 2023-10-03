package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.NhanVienRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.NhanVienResponse;
import com.example.beclothingsalesmanager.services.NhanVienService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/admin/nhan-vien")
public class NhanVienController {
    @Autowired
    private NhanVienService nhanVienService;

    @GetMapping("")
    public ResponseEntity<?> findAll(){
        List<NhanVienResponse> nhanVienResponses = nhanVienService.getAll();
        return ResponseEntity.ok().body(nhanVienResponses);
    }
    @PostMapping("")
    public void create(@RequestBody NhanVienRequest nhanVienRequest) {
        nhanVienService.add(nhanVienRequest);
    }

    @PutMapping("/{id}")
    public void update(@RequestBody NhanVienRequest nhanVienRequest, @PathVariable("id") UUID id) {
        nhanVienService.update(nhanVienRequest, id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable UUID id) {
        nhanVienService.delete(id);

    }
}
