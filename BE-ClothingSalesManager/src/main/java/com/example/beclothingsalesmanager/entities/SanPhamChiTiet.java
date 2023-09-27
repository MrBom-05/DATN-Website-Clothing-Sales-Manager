package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "san_pham_chi_tiet")
public class SanPhamChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(name = "ma_san_pham", length = 20)
    private String maSanPham;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_san_pham")
    private SanPham idSanPham;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_kich_co")
    private KichCo idKichCo;

    @Column(name = "gia_nhap", precision = 20)
    private BigDecimal giaNhap;

    @Column(name = "gia_ban", precision = 20)
    private BigDecimal giaBan;

    @Column(name = "so_luong")
    private Integer soLuong;

    @Nationalized
    @Lob
    @Column(name = "mo_ta")
    private String moTa;

    @Column(name = "trang_thai")
    private Integer trangThai;

    @OneToMany(mappedBy = "idSanPhamChiTiet")
    private Set<GioHangChiTiet> gioHangChiTiets = new LinkedHashSet<>();

    @OneToMany(mappedBy = "idSanPhamChiTiet")
    private Set<HoaDonChiTiet> hoaDonChiTiets = new LinkedHashSet<>();

    @OneToMany(mappedBy = "idSanPhamChiTiet")
    private Set<KhuyenMaiChiTiet> khuyenMaiChiTiets = new LinkedHashSet<>();

}