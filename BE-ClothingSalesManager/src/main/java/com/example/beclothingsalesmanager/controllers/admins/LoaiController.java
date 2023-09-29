package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.responses.LoaiReponse;
import com.example.beclothingsalesmanager.services.LoaiService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/loai")
public class LoaiController {
    @Autowired
    private LoaiService loaiService;

    @GetMapping
    public ResponseEntity<?> findPage(@RequestParam(defaultValue = "0", name = "page") int page){
        Page<LoaiReponse> loaiReponses = loaiService.findAllPage(page);
        return ResponseEntity.ok().body(loaiReponses.getContent());
    }

    @PostMapping
    public ResponseEntity<?> add(@Valid @RequestBody LoaiReponse loaiReponse, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            loaiService.add(loaiReponse);
            return ResponseEntity.ok().body("Thêm thành công");
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @RequestBody LoaiReponse loaiReponse, BindingResult bindingResult, @PathVariable("id") Integer id) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            loaiService.update(loaiReponse, id);
            return ResponseEntity.ok().body("Sửa thành công");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Integer id) {
        loaiService.delete(id);
        return ResponseEntity.ok().body("Xóa thành công");
    }
}
