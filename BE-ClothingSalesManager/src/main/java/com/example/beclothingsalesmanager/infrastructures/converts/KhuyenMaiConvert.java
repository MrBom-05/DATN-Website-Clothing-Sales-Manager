package com.example.beclothingsalesmanager.infrastructures.converts;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.entities.KhuyenMai;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import com.example.beclothingsalesmanager.infrastructures.responses.KhuyenMaiResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class KhuyenMaiConvert {
    @Autowired
    private ModelMapper modelMapper;


    public KhuyenMai mapToEntity(KhuyenMaiResponse khuyenMaiResponse) {
        return modelMapper.map(khuyenMaiResponse, KhuyenMai.class);
    }

    public KhuyenMaiResponse mapToViewModel(KhuyenMai khuyenMai) {
        return modelMapper.map(khuyenMai, KhuyenMaiResponse.class);
    }

    public Stream<KhuyenMaiResponse> mapToListViewModel(List<KhuyenMai> entities) {
        List<KhuyenMaiResponse> giamGiaRepons = entities.stream()
                .map(this::mapToViewModel)
                .collect(Collectors.toList());
        return giamGiaRepons.stream();
    }
}
