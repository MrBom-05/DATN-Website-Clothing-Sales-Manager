package com.example.websitebanquanao.infrastructures.requests;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class MauSacRequest {
    @NotBlank(message = "Tên mà không được để trống")
    private String ten;
    @NotBlank(message = "Mã màu được để trống")
    private String maMauSac;
}
