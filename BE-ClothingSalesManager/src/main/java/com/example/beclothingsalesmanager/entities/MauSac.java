package com.example.beclothingsalesmanager.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "mau_sac")
public class MauSac {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Nationalized
    @Column(name = "ten", nullable = false, length = 50)
    private String ten;

    @Column(name = "ma_mau_sac", nullable = false, length = 10)
    private String maMauSac;

    @OneToMany(mappedBy = "idMauSac")
    private Set<SanPham> sanPhams = new LinkedHashSet<>();

}