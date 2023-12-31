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
    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id,sp.idLoai.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp ORDER BY sp.ten")
    public List<SanPhamResponse> getAll();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.KhuyenMaiChiTietResponse(s.id, s.ten, s.idLoai.ten) from SanPham s")
    public List<KhuyenMaiChiTietResponse> getAllKhuyenMai();

    @Query(value = "SELECT distinct sp.*\n" +
            "FROM san_pham sp\n" +
            "         LEFT JOIN san_pham_chi_tiet spct ON sp.id = spct.id_san_pham\n" +
            "         LEFT JOIN khuyen_mai_chi_tiet kmct ON spct.id = kmct.id_san_pham_chi_tiet\n" +
            "        left join khuyen_mai km on kmct.id_khuyen_mai = km.id\n" +
            "        left join loai lsp on sp.id_loai = lsp.id\n" +
            "WHERE\n" +
            "      not exists(select  km.*\n" +
            "                 from khuyen_mai km join khuyen_mai_chi_tiet kmct on km.id = kmct.id_khuyen_mai\n" +
            "                 where km.trang_thai = 0\n" +
            "                   and kmct.id_san_pham_chi_tiet = spct.id\n" +
            "                )",nativeQuery = true)
        List<SanPham> getAllKhuyenMai2();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id,sp.idLoai.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp ORDER BY sp.ten")
    public Page<SanPhamResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamResponse(sp.id,sp.idLoai.id, sp.ten, sp.ngayTao, sp.anh, sp.idLoai.ten) from SanPham sp where sp.id = :id")
    public SanPhamResponse getByIdResponse(@Param("id") UUID id);


    // user
    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms where spct.trangThai = 1 group by s.id, s.ten, s.anh, s.ngayTao order by s.ngayTao desc")
    public List<TrangChuResponse> getListTrangChu();
    @Query(value = "SELECT TOP 5 s.id, s.ten, s.anh, MIN(spct.gia), MIN(ms.id), s.ngay_tao " +
            "FROM san_pham s " +
            "JOIN san_pham_chi_tiet spct ON s.id = spct.id_san_pham " +
            "JOIN mau_sac ms ON spct.id_mau_sac = ms.id " +
            "JOIN hoa_don_chi_tiet hdct ON spct.id = hdct.id_san_pham_chi_tiet " +
            "JOIN hoa_don hd ON hdct.id_hoa_don = hd.id " +
            "WHERE spct.trang_thai = 1 " +
            "GROUP BY s.id, s.ten, s.anh, s.ngay_tao " +
            "ORDER BY COUNT(hdct.id) DESC", nativeQuery = true)
    public List<Object[]> getTop5BestSellingProducts();






    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, MIN(spct.gia), MIN(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms join spct.khuyenMaiChiTiets kmct join kmct.idKhuyenMai km where km.ngayBatDau <= CURRENT_DATE and km.ngayKetThuc >= CURRENT_DATE and spct.trangThai = 1 group by s.id, s.ten, s.anh, s.ngayTao order by s.ngayTao desc")
    public List<TrangChuResponse> getListSale();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.TrangChuResponse(s.id, s.ten, s.anh, min(spct.gia), min(ms.id), s.ngayTao) from SanPham s join s.sanPhamChiTiets spct join spct.idMauSac ms where s.idLoai.id = :idLoai and spct.trangThai = 1 group by s.id, s.ten, s.anh, s.ngayTao order by s.ngayTao desc")
    public List<TrangChuResponse> getListSanPhamByIdLoai(@Param("idLoai") Integer idLoai);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietUserResponse(s.id, s.ten, min(spct.gia), spct.moTa) from SanPham s join s.sanPhamChiTiets spct where s.id = :idSanPham group by s.id, s.ten, spct.moTa")
    public SanPhamChiTietUserResponse getByIdSanPham(@Param("idSanPham") UUID idSanPham);

    @Query("SELECT DISTINCT new com.example.websitebanquanao.infrastructures.responses.LoaiResponse(sp.idLoai.id, sp.idLoai.ten) FROM SanPham sp ORDER BY sp.idLoai.ten")
    public List<LoaiResponse> getListLoai();

    @Query("select sp from SanPham sp where sp.ten = :ten")
    SanPham findByTen(String ten);
}
