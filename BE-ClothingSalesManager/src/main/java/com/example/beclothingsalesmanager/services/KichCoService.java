package com.example.beclothingsalesmanager.services;

import com.example.beclothingsalesmanager.entities.KichCo;
import com.example.beclothingsalesmanager.infrastructures.requests.KichCoRequest;
import com.example.beclothingsalesmanager.infrastructures.responses.KichCoResponse;
import com.example.beclothingsalesmanager.repositories.KichCoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KichCoService {
    @Autowired
    private KichCoRepository kichCoRepository;

    public List<KichCoResponse> getAll() {
        return kichCoRepository.getAll();
    }

    public void add(KichCoRequest kichCoRequest) {
        KichCo kichCo = new KichCo();
        kichCo.setTen(kichCoRequest.getTen());
        kichCoRepository.save(kichCo);

        System.out.println("KichCoService.add: " + kichCo.getTen());
    }

    public void delete(Integer id) {
        KichCo kichCo = kichCoRepository.findById(id).orElse(null);
        if (kichCo != null) {
            kichCoRepository.deleteById(id);

            System.out.println("KichCoService.delete: " + id);
        } else {
            System.out.println("KichCoService.delete: null");
        }
    }
}
