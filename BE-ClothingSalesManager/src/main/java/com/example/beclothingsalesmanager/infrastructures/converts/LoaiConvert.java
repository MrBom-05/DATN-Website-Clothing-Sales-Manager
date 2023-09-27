package com.example.beclothingsalesmanager.infrastructures.converts;

import com.example.beclothingsalesmanager.entities.Loai;
import com.example.beclothingsalesmanager.infrastructures.responses.LoaiReponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
@Component
public class LoaiConvert {
    @Autowired
    private ModelMapper modelMapper;

    public Loai mapToEntity(LoaiReponse loaiReponse) {
        return modelMapper.map(loaiReponse, Loai.class);
    }

    public LoaiReponse mapToViewModel(Loai loai) {
        return modelMapper.map(loai, LoaiReponse.class);
    }

    public Stream<LoaiReponse> mapToListViewModel(List<Loai> entities) {
        List<LoaiReponse> loaiRepon = entities.stream()
                .map(this::mapToViewModel)
                .collect(Collectors.toList());
        return loaiRepon.stream();
    }
}
