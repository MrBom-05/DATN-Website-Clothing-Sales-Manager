package com.example.beclothingsalesmanager.infrastructures.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class NhanVienResponse {
    private UUID id;
    private String ma;
    private String hoVaTen;
    private String email;
    private String soDienThoai;
    private String diaChi;
    private String xaPhuong;
    private String quanHuyen;
    private String tinhThanhPho;
    private Instant ngayVaoLam;
    private Integer chucVu;
    private Integer trangThai;

}
