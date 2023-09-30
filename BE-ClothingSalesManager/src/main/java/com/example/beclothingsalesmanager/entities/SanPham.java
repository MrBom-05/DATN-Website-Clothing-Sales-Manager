package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "san_pham")
public class SanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false)
    private UUID id;

    @Nationalized
    @Lob
    @Column(name = "ten", nullable = false)
    private String ten;

    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_loai", nullable = false)
    private Loai idLoai;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_mau_sac", nullable = false)
    private MauSac idMauSac;

    @OneToMany(mappedBy = "idSanPham")
    private Set<AnhSanPham> anhSanPhams = new LinkedHashSet<>();

    @OneToMany(mappedBy = "idSanPham")
    private Set<SanPhamChiTiet> sanPhamChiTiets = new LinkedHashSet<>();

}