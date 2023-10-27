package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.GiamGia;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface GiamGiaRepository extends JpaRepository<GiamGia, UUID> {
    @Query("select new com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc) from GiamGia g")
    public Page<GiamGiaResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc) from GiamGia g where g.id = :id")
    public GiamGiaResponse getByIdResponse(@Param("id") UUID id);

    // Phương thức kiểm tra sự tồn tại của mã giảm giá
    boolean existsByMa(String ma);


}
