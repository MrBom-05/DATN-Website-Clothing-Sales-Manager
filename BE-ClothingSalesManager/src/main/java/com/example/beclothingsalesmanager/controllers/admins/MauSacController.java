package com.example.beclothingsalesmanager.controllers.admins;

import com.example.beclothingsalesmanager.infrastructures.responses.MauSacReponse;
import com.example.beclothingsalesmanager.services.MauSacService;
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
@RequestMapping("/admin/mau-sac")
public class MauSacController {
    @Autowired
    private MauSacService mauSacService;

    @GetMapping
    public ResponseEntity<?> findPage(@RequestParam(defaultValue = "0", name = "page") int page){
        Page<MauSacReponse> mauSacReponses = mauSacService.findAllPage(page);
        return ResponseEntity.ok().body(mauSacReponses.getContent());
    }

    @PostMapping
    public ResponseEntity<?> add(@Valid @RequestBody MauSacReponse mauSacReponse, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            mauSacService.add(mauSacReponse);
            return ResponseEntity.ok().body("Thêm thành công");
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @RequestBody MauSacReponse mauSacReponse, BindingResult bindingResult, @PathVariable("id") Integer id) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        } else {
            mauSacService.update(mauSacReponse, id);
            return ResponseEntity.ok().body("Sửa thành công");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Integer id) {
        mauSacService.delete(id);
        return ResponseEntity.ok().body("Xóa thành công");
    }

}
