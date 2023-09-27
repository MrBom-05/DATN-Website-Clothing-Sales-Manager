package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "khuyen_mai")
public class KhuyenMai {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(name = "ma", length = 10)
    private String ma;

    @Column(name = "so_pham_tram_giam")
    private Integer soPhamTramGiam;

    @Column(name = "ngay_bat_dau")
    private LocalDate ngayBatDau;

    @Column(name = "ngay_ket_thuc")
    private LocalDate ngayKetThuc;

    @Column(name = "trang_thai")
    private Integer trangThai;

    @OneToMany(mappedBy = "idKhuyenMai")
    private Set<HoaDon> hoaDons = new LinkedHashSet<>();

}