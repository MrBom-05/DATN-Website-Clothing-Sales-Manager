package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.requests.LoaiRequest;
import com.example.beclothingsalesmanager.services.LoaiService;
import jakarta.validation.Valid;
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
@RequestMapping("/admin/loai")
public class LoaiController {
    @Autowired
    private LoaiService loaiService;

    @GetMapping
    public ResponseEntity<?> getAll(){
        return ResponseEntity.ok().body(loaiService.getAll());
    }

    @PostMapping
    public void add(@RequestBody LoaiRequest loaiRequest){
        loaiService.add(loaiRequest);
        System.out.println("Thêm thành công " + loaiRequest.getTen());
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        loaiService.delete(id);
        System.out.println("Xóa thành công " + id);
    }
}
