package com.example.beclothingsalesmanager.infrastructures.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class KhachHangReponse {
    private UUID id;
    private String hoVaTen;
    private String email;
    private String soDienThoai;
    private String matKhau;
    private String diaChi;
    private String xaPhuong;
    private String quanHuyen;
    private String tinhThanhPho;


}
