package com.example.beclothingsalesmanager.infrastructures.converts;

import com.example.beclothingsalesmanager.entities.GiamGia;
import com.example.beclothingsalesmanager.infrastructures.responses.GiamGiaResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.modelmapper.ModelMapper;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class GiamGiaConvert {
    @Autowired
    private ModelMapper modelMapper;

    public GiamGia mapToEntity(GiamGiaResponse giamGiaResponse) {
        return modelMapper.map(giamGiaResponse, GiamGia.class);
    }

    public GiamGiaResponse mapToViewModel(GiamGia giamGia) {
        return modelMapper.map(giamGia, GiamGiaResponse.class);
    }

    public Stream<GiamGiaResponse> mapToListViewModel(List<GiamGia> entities) {
        List<GiamGiaResponse> giamGiaRepons = entities.stream()
                .map(this::mapToViewModel)
                .collect(Collectors.toList());
        return giamGiaRepons.stream();
    }
}
