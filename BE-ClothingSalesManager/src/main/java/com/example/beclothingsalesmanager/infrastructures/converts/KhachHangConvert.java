package com.example.beclothingsalesmanager.infrastructures.converts;

import com.example.beclothingsalesmanager.entities.KhachHang;
import com.example.beclothingsalesmanager.infrastructures.responses.KhachHangReponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class KhachHangConvert {
    @Autowired
    private ModelMapper modelMapper;

    public KhachHang mapToEntity(KhachHangReponse khachHangReponse) {
        return modelMapper.map(khachHangReponse, KhachHang.class);
    }

    public KhachHangReponse mapToViewModel(KhachHang khachHang) {
        return modelMapper.map(khachHang, KhachHangReponse.class);
    }

    public Stream<KhachHangReponse> mapToListViewModel(List<KhachHang> entities) {
        List<KhachHangReponse> khachHangRepon = entities.stream()
                .map(this::mapToViewModel)
                .collect(Collectors.toList());
        return khachHangRepon.stream();
    }






}
