package com.cykt.persistence.repository;

import com.cykt.persistence.entity.PlatEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface PlatRepository extends JpaRepository<PlatEntity, UUID> {
    public PlatEntity findByName(String name);
}
