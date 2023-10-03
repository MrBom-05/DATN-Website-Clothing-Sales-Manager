package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "hoa_don")
public class HoaDon {
    @Id
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(name = "ma", nullable = false, length = 50)
    private String ma;

    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @Column(name = "ngay_thanh_toan")
    private Instant ngayThanhToan;

    @Column(name = "ngay_van_chuyen")
    private Instant ngayVanChuyen;

    @Column(name = "ngay_nhan")
    private Instant ngayNhan;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_khach_hang")
    private KhachHang idKhachHang;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_nhan_vien")
    private NhanVien idNhanVien;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_khuyen_mai")
    private KhuyenMai idKhuyenMai;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_giam_gia")
    private GiamGia idGiamGia;

    @Nationalized
    @Column(name = "nguoi_nhan", length = 100)
    private String nguoiNhan;

    @Nationalized
    @Column(name = "email", length = 50)
    private String email;

    @Nationalized
    @Column(name = "so_dien_thoai", length = 15)
    private String soDienThoai;

    @Column(name = "hinh_thuc_thanh_toan")
    private Integer hinhThucThanhToan;

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

    @Column(name = "trang_thai")
    private Integer trangThai;

}