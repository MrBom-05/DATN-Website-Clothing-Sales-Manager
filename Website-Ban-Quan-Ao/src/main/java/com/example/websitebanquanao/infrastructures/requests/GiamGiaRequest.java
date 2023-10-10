package com.example.websitebanquanao.infrastructures.requests;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class GiamGiaRequest {
    private Integer ma;
    private Integer soPhanTramGiam;
    private Integer soLuong;
    private LocalDate ngayBatDau;
    private LocalDate ngayKetThuc;
}
