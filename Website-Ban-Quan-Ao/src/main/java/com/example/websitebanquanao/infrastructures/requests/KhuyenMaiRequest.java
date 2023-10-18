package com.example.websitebanquanao.infrastructures.requests;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class KhuyenMaiRequest {
    private String ma;
    private String ten;
    private Integer soPhanTramGiam;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private Integer trangThai;
}
