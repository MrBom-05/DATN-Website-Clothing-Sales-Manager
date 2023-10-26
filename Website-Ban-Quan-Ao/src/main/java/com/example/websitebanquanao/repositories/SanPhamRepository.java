package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.SanPham;
import com.example.websitebanquanao.infrastructures.responses.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, UUID> {

    // admin
    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp ORDER BY sp.ten")
    public List<SanPhamResponse> getAll();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.KhuyenMaiChiTietResponse(s.id, s.ten, s.idLoai.ten) from SanPham s")
    public List<KhuyenMaiChiTietResponse> getAllKhuyenMai();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp ORDER BY sp.ten")
    public Page<SanPhamResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp where sp.id = :id")
    public SanPhamResponse getByIdResponse(@Param("id") UUID id);


    // user
    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms group by s.id, s.ten, s.anh, s.ngayTao order by s.ngayTao desc")
    public List<TrangChuResponse> getListTrangChu();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms group by s.id, s.ten, s.anh ,s.ngayTao order by min(spct.gia) asc")
    public List<TrangChuResponse> getListTrangChuASC();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms group by s.id, s.ten, s.anh, s.ngayTao order by min(spct.gia) desc")
    public List<TrangChuResponse> getListTrangChuDESC();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms where s.idLoai.id = :idLoai group by s.id, s.ten, s.anh, s.ngayTao order by s.ngayTao desc")
    public List<TrangChuResponse> getListSanPhamByIdLoai(@Param("idLoai") Integer idLoai);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms where s.idLoai.id = :idLoai group by s.id, s.ten, s.anh, s.ngayTao order by min(spct.gia) asc")
    public List<TrangChuResponse> getListSanPhamByIdLoaiASC(@Param("idLoai") Integer idLoai);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms where s.idLoai.id = :idLoai group by s.id, s.ten, s.anh, s.ngayTao order by min(spct.gia) desc")
    public List<TrangChuResponse> getListSanPhamByIdLoaiDESC(@Param("idLoai") Integer idLoai);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietUserResponse(s.id, s.ten, min(spct.gia), max(spct.gia), spct.moTa) from SanPham s join s.sanPhamChiTiets spct where s.id = :idSanPham group by s.id, s.ten, spct.moTa")
    public SanPhamChiTietUserResponse getByIdSanPham(@Param("idSanPham") UUID idSanPham);

    @Query("SELECT DISTINCT new com.example.websitebanquanao.infrastructures.responses.LoaiResponse(sp.idLoai.id, sp.idLoai.ten) FROM SanPham sp ORDER BY sp.idLoai.ten")
    public List<LoaiResponse> getListLoai();
}
