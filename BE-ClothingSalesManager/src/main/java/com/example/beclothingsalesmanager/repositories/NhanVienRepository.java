package com.example.beclothingsalesmanager.repositories;

import com.example.beclothingsalesmanager.entities.NhanVien;
import com.example.beclothingsalesmanager.infrastructures.responses.NhanVienResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface NhanVienRepository extends JpaRepository<NhanVien, UUID> {
    @Query("select new com.example.beclothingsalesmanager.infrastructures.responses.NhanVienResponse(nv.id, nv.ma, nv.hoVaTen, nv.soDienThoai, nv.email, nv.diaChi, nv.xaPhuong, nv.quanHuyen, nv.tinhThanhPho, nv.ngayVaoLam, nv.chucVu, nv.trangThai) from NhanVien nv")
    public List<NhanVienResponse> getAll();
}