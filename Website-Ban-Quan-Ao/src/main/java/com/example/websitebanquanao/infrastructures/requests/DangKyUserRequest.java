package com.example.websitebanquanao.infrastructures.requests;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DangKyUserRequest {
    private String hoTen;
    private String emailDK;
    private String matKhauDK;
}
