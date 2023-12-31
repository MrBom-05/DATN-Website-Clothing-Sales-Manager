package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.entities.Loai;
import com.example.websitebanquanao.entities.SanPham;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.SanPhamRequest;
import com.example.websitebanquanao.infrastructures.responses.*;
import com.example.websitebanquanao.repositories.SanPhamRepository;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Service
public class SanPhamService {
    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Autowired
    private KhuyenMaiChiTietService khuyenMaiChiTietService;

    // admin

    public List<SanPhamResponse> getAll() {
        return sanPhamRepository.getAll();
    }

    public List<KhuyenMaiChiTietResponse> getAllKhuyenMai() {
        return sanPhamRepository.getAllKhuyenMai();
    }

    public Page<SanPhamResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return sanPhamRepository.getPage(pageable);
    }

    private String encodeImageToBase64(MultipartFile file) throws IOException {
        byte[] fileContent = file.getBytes();
        return Base64.encodeBase64String(fileContent);
    }

    public void add(SanPhamRequest sanPhamRequest, MultipartFile anh) {

        try {
            SanPham sanPham = new SanPham();
            sanPham.setTen(sanPhamRequest.getTen());
            sanPham.setAnh("data:image/png;base64," + encodeImageToBase64(anh));

            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            sanPham.setNgayTao(date);

            Loai loai = new Loai();
            loai.setId(sanPhamRequest.getIdLoai());

            sanPham.setIdLoai(loai);
            sanPhamRepository.save(sanPham);

            System.out.println("SanPhamService.add: " + sanPham.getTen());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    // check trùng tên
    public Boolean checkTen(String ten) {
        SanPham sanPham = sanPhamRepository.findByTen(ten);
        if (sanPham != null) {
            return true;
        } else {
            return false;
        }
    }
    public void update(SanPhamRequest sanPhamRequest, UUID id, MultipartFile anh) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham != null) {
            sanPham.setTen(sanPhamRequest.getTen());
            if (anh.isEmpty()) {
                sanPham.setAnh(sanPham.getAnh());
            } else {
                try {
                    sanPham.setAnh("data:image/png;base64," + encodeImageToBase64(anh));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            Loai loai = new Loai();
            loai.setId(sanPhamRequest.getIdLoai());

            sanPham.setIdLoai(loai);

            sanPhamRepository.save(sanPham);

            System.out.println("SanPhamService.update: " + sanPham.getTen());
        } else {
            System.out.println("SanPhamService.update: null");
        }
    }

    public void delete(UUID id) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham != null) {
            sanPhamRepository.delete(sanPham);

            System.out.println("SanPhamService.delete: " + sanPham.getTen());
        } else {
            System.out.println("SanPhamService.delete: null");
        }
    }

    public SanPhamResponse getById(UUID id) {
        SanPhamResponse sanPhamResponse = sanPhamRepository.getByIdResponse(id);
        if (sanPhamResponse != null) {
            System.out.println("SanPhamService.findById: " + sanPhamResponse.getTen());
            return sanPhamResponse;
        } else {
            System.out.println("SanPhamService.findById: null");
            return null;
        }
    }


    // user
    public List<TrangChuResponse> getListTrangChu(String sort) {
        List<TrangChuResponse> list = sanPhamRepository.getListTrangChu();
        if (sort != null) {
            if (sort.equals("asc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia));
            } else if (sort.equals("desc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia).reversed());
            }
        }
        return list;
    }
    public List<TrangChuResponse> getListBanChay(String sort) {
        List<TrangChuResponse> list = transformToResponse(sanPhamRepository.getTop5BestSellingProducts());
        if (sort != null) {
            if (sort.equals("asc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia));
            } else if (sort.equals("desc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia).reversed());
            }
        }
        return list;
    }
    public List<TrangChuResponse> getListSanPhamByIdLoai(Integer idLoai, String sort) {
        List<TrangChuResponse> list = sanPhamRepository.getListSanPhamByIdLoai(idLoai);
        if (sort != null) {
            if (sort.equals("asc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia));
            } else if (sort.equals("desc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia).reversed());
            }
        }
        return list;
    }

    public List<TrangChuResponse> getListSale(String sort) {
        List<TrangChuResponse> list = sanPhamRepository.getListSale();
        if (sort != null) {
            if (sort.equals("asc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia));
            } else if (sort.equals("desc")) {
                list.sort(Comparator.comparing(TrangChuResponse::getGia).reversed());
            }
        }
        return list;
    }

    public List<LoaiResponse> getListLoai() {
        return sanPhamRepository.getListLoai();
    }

    public SanPhamChiTietUserResponse getByIdSanPham(UUID idSanPham) {
        return sanPhamRepository.getByIdSanPham(idSanPham);
    }
    public List<SanPham> getAllKhuyenMai2() {
        return sanPhamRepository.getAllKhuyenMai2();
    }
    public List<TrangChuResponse> transformToResponse(List<Object[]> resultList) {
        List<TrangChuResponse> responseList = new ArrayList<>();
        for (Object[] result : resultList) {
            TrangChuResponse response = new TrangChuResponse();
            response.setId(UUID.fromString(result[0].toString()));
            response.setTen(result[1].toString());
            response.setAnh(result[2].toString());
            response.setGia(new BigDecimal(result[3].toString()));
            response.setIdMauSac(Integer.parseInt(result[4].toString()));
            response.setNgayTao((Date) result[5]);
            responseList.add(response);
        }
        return responseList;
    }

}
