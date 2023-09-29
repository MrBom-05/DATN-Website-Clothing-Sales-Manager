package com.example.beclothingsalesmanager.infrastructures.converts;

import com.example.beclothingsalesmanager.entities.MauSac;
import com.example.beclothingsalesmanager.infrastructures.responses.MauSacReponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class MauSacConvert {
    @Autowired
    private ModelMapper modelMapper;

    public MauSac mapToEntity(MauSacReponse mauSacReponse) {
        return modelMapper.map(mauSacReponse, MauSac.class);
    }

    public MauSacReponse mapToViewModel(MauSac mauSac) {
        return modelMapper.map(mauSac, MauSacReponse.class);
    }

    public Stream<MauSacReponse> mapToListViewModel(List<MauSac> entities) {
        List<MauSacReponse> mauSacRepon = entities.stream()
                .map(this::mapToViewModel)
                .collect(Collectors.toList());
        return mauSacRepon.stream();
    }
}
