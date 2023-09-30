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
public class SanPhamResponse {
    private UUID id;
    private String ten;
    private Instant ngayTao;
    private String tenLoai;
    private String tenMauSac;
}
