package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "nhan_vien")
public class NhanVien {
    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "ma", nullable = false, length = 20)
    private String ma;

    @Nationalized
    @Column(name = "ho_va_ten", length = 100)
    private String hoVaTen;

    @Nationalized
    @Column(name = "email", length = 50)
    private String email;

    @Nationalized
    @Column(name = "so_dien_thoai", length = 15)
    private String soDienThoai;

    @Nationalized
    @Column(name = "mat_khau", length = 50)
    private String matKhau;

    @Nationalized
    @Column(name = "dia_chi", length = 100)
    private String diaChi;

    @Nationalized
    @Column(name = "xa_phuong", length = 80)
    private String xaPhuong;

    @Nationalized
    @Column(name = "quan_huyen", length = 80)
    private String quanHuyen;

    @Nationalized
    @Column(name = "tinh_thanh_pho", length = 80)
    private String tinhThanhPho;

    @Column(name = "ngay_vao_lam")
    private Instant ngayVaoLam;

    @Column(name = "trang_thai")
    private Integer trangThai;

    @Column(name = "chuc_vu")
    private Integer chucVu;

}