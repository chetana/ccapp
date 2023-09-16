package com.cykt.business;

import com.cykt.persistence.entity.PlatEntity;
import com.cykt.persistence.repository.PlatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PlatService {
    private final PlatRepository platRepository;

    public PlatEntity findByName(String name) {
        return platRepository.findByName(name);
    }
//    public PlatEntity save(Plat platEntity) {
//
//        return platRepository.save(platEntity);
//    }
}
