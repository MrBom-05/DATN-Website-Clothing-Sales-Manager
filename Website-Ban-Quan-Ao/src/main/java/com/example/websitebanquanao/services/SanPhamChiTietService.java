package com.example.websitebanquanao.services;

import com.example.websitebanquanao.configs.QRCodeGenerator;
import com.example.websitebanquanao.entities.KichCo;
import com.example.websitebanquanao.entities.MauSac;
import com.example.websitebanquanao.entities.SanPham;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.SanPhamChiTietRequest;
import com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse;
import com.example.websitebanquanao.infrastructures.responses.NhanVienResponse;
import com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse;
import com.example.websitebanquanao.repositories.SanPhamChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Service
public class SanPhamChiTietService {
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;
    @Autowired
    private AnhSanPhamService anhSanPhamService;
    @Autowired
    private QRCodeGenerator qrCodeGenerator;

    // admin

    public List<SanPhamChiTietResponse> getAll() {
        return sanPhamChiTietRepository.getAll();
    }

    public Page<BanHangTaiQuayResponse> findAllCtsp(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return sanPhamChiTietRepository.findAllCtsp(pageable);
    }


    public void add(SanPhamChiTietRequest sanPhamChiTietRequest) {
        SanPhamChiTiet sanPhamChiTiet = new SanPhamChiTiet();
        sanPhamChiTiet.setMaSanPham(sanPhamChiTietRequest.getMaSanPham());
        sanPhamChiTiet.setGia(sanPhamChiTietRequest.getGia());
        sanPhamChiTiet.setSoLuong(sanPhamChiTietRequest.getSoLuong());
        sanPhamChiTiet.setMoTa(sanPhamChiTietRequest.getMoTa());
        sanPhamChiTiet.setTrangThai(sanPhamChiTietRequest.getTrangThai());

        SanPham sanPham = new SanPham();
        sanPham.setId(sanPhamChiTietRequest.getIdSanPham());

        MauSac mauSac = new MauSac();
        mauSac.setId(sanPhamChiTietRequest.getIdMauSac());

        KichCo kichCo = new KichCo();
        kichCo.setId(sanPhamChiTietRequest.getIdKichCo());

        sanPhamChiTiet.setIdSanPham(sanPham);
        sanPhamChiTiet.setIdMauSac(mauSac);
        sanPhamChiTiet.setIdKichCo(kichCo);

        SanPhamChiTiet sanPhamChiTietSaved = sanPhamChiTietRepository.save(sanPhamChiTiet);
        String qrCodeData = String.valueOf(sanPhamChiTietSaved.getId());
        String filePath = "src/main/java/com/example/websitebanquanao/images/" + sanPhamChiTietSaved.getMaSanPham() + ".png";
        qrCodeGenerator.generateQRCode(qrCodeData, filePath);
        anhSanPhamService.add(sanPhamChiTietSaved, sanPhamChiTietRequest.getDuongDan());

        System.out.println("SanPhamChiTietService.add: " + sanPhamChiTietSaved.getId());
        System.out.println("file đường dẫn: " + filePath);
    }

    public void update(SanPhamChiTietRequest sanPhamChiTietRequest, UUID id) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet != null) {
            sanPhamChiTiet.setMaSanPham(sanPhamChiTietRequest.getMaSanPham());
            sanPhamChiTiet.setGia(sanPhamChiTietRequest.getGia());
            sanPhamChiTiet.setSoLuong(sanPhamChiTietRequest.getSoLuong());
            sanPhamChiTiet.setMoTa(sanPhamChiTietRequest.getMoTa());
            sanPhamChiTiet.setTrangThai(sanPhamChiTietRequest.getTrangThai());

            SanPham sanPham = new SanPham();
            sanPham.setId(sanPhamChiTietRequest.getIdSanPham());

            MauSac mauSac = new MauSac();
            mauSac.setId(sanPhamChiTietRequest.getIdMauSac());

            KichCo kichCo = new KichCo();
            kichCo.setId(sanPhamChiTietRequest.getIdKichCo());

            sanPhamChiTiet.setIdSanPham(sanPham);
            sanPhamChiTiet.setIdMauSac(mauSac);
            sanPhamChiTiet.setIdKichCo(kichCo);

            sanPhamChiTietRepository.save(sanPhamChiTiet);
            System.out.println("SanPhamChiTietService.update: " + sanPhamChiTiet.getId());
        }
    }

    public void delete(UUID id) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet != null) {
            sanPhamChiTietRepository.deleteById(id);
            System.out.println("SanPhamChiTietService.delete: " + id);
        }
    }

    public SanPhamChiTiet findById(UUID idSanPhamChiTiet) {
        if (sanPhamChiTietRepository.findById(idSanPhamChiTiet).isPresent()) {
            return sanPhamChiTietRepository.findById(idSanPhamChiTiet).get();
        } else {
            return null;
        }
    }

    public void updateSoLuong(SanPhamChiTiet sanPhamChiTiet) {
        sanPhamChiTietRepository.save(sanPhamChiTiet);
    }

    @Transactional
    public void updateSoLuongAfterDelete(UUID idSanPhamChiTiet, int currentSoLuong) {
        // Gọi phương thức tương ứng từ repository để thực hiện việc cập nhật số lượng
        sanPhamChiTietRepository.updateSoLuongAfterDelete(idSanPhamChiTiet, currentSoLuong);
    }

    public List<SanPhamChiTiet> findByIdSanPham(UUID idSanPham) {
        return sanPhamChiTietRepository.findSanPhamChiTietByIdSanPham(idSanPham);
    }

    // user
    public SanPhamChiTiet getByIdSanPhamAndIdMauSacAndIdKichCo(UUID idSanPham, Integer idMauSac, Integer idKichCo) {
        System.out.println("SanPhamChiTietService.getByIdSanPhamAndIdMauSacAndIdKichCo: " + idSanPham + " " + idMauSac + " " + idKichCo);
        return sanPhamChiTietRepository.getByIdSanPhamAndIdMauSacAndIdKichCo(idSanPham, idMauSac, idKichCo);
    }

    public List<SanPhamChiTietResponse> getByStatus(Integer trangThai) {
        return sanPhamChiTietRepository.getByStatus(trangThai);
    }

    public List<SanPhamChiTietResponse> getByTenMauSac(String tenMauSac) {
        return sanPhamChiTietRepository.getByTenMauSac(tenMauSac);
    }

    public List<SanPhamChiTietResponse> getByTenKichCo(String tenKichCo) {
        return sanPhamChiTietRepository.getByTenKichCo(tenKichCo);
    }
}
