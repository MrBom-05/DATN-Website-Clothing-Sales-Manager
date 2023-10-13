package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse;
import com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet, UUID> {
    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse(s.id, s.maSanPham, s.idSanPham.ten, s.idMauSac.ten, s.idKichCo.ten, s.gia, s.soLuong, s.moTa, s.trangThai) from SanPhamChiTiet s")
    public List<SanPhamChiTietResponse> getAll();


    @Query("select new com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse(s.id, s.idSanPham, s.idMauSac, s.idKichCo, s.gia, s.soLuong, s.moTa, s.trangThai) from SanPhamChiTiet s where s.trangThai = 1")
    public Page<BanHangTaiQuayResponse> findAllCtsp(Pageable pageable);


    @Modifying
    @Query("UPDATE SanPhamChiTiet ctsp SET ctsp.soLuong = :currentSoLuong WHERE ctsp.id = :idSanPhamChiTiet")
    void updateSoLuongAfterDelete(@Param("idSanPhamChiTiet") UUID idSanPhamChiTiet, @Param("currentSoLuong") int currentSoLuong);


}
