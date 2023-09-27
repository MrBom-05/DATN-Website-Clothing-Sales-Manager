package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "giam_gia")
public class GiamGia {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(name = "ma")
    private Integer ma;

    @Column(name = "so_pham_tram_giam")
    private Integer soPhamTramGiam;

    @Column(name = "ngay_ket_thuc")
    private LocalDate ngayKetThuc;

    @OneToMany(mappedBy = "idGiamGia")
    private Set<HoaDon> hoaDons = new LinkedHashSet<>();

}