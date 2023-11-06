package com.example.websitebanquanao.infrastructures.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class HoaDonUserResponse {
    private String ma;
    private Integer trangThai;
    private Instant ngayTao;
    private Instant ngayThanhToan;
    private String nguoiNhan;
    private String diaChi;
    private String xaPhuong;
    private String quanHuyen;
    private String tinhThanhPho;
    private String email;
    private String soDienThoai;
    private BigDecimal phiVanChuyen;
    private String ghiChu;
}
