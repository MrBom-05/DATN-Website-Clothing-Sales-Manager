package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.KhuyenMai;
import com.example.websitebanquanao.infrastructures.responses.KhuyenMaiResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface KhuyenMaiRepository extends JpaRepository<KhuyenMai, UUID> {

    @Query("select new com.example.websitebanquanao.infrastructures.responses.KhuyenMaiResponse(km.id, km.ma, km.ten, km.soPhanTramGiam, km.ngayBatDau, km.ngayKetThuc, km.trangThai) from KhuyenMai km")
    public Page<KhuyenMaiResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.KhuyenMaiResponse(km.id, km.ma, km.ten, km.soPhanTramGiam, km.ngayBatDau, km.ngayKetThuc, km.trangThai) from KhuyenMai km where km.id = :id")
    public KhuyenMaiResponse getByIdResponse(@Param("id") UUID id);

    @Modifying
    @Query("update KhuyenMai km set km.trangThai = :trangThai where km.id = :id")
    public void updateTrangThaiById(@Param("id") UUID id, @Param("trangThai") int trangThai);

    boolean existsByMa(String ma);
}
