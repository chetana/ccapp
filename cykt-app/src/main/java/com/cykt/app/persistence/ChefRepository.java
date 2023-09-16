package com.cykt.app.persistence;

import com.cykt.app.entity.ChefEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ChefRepository extends JpaRepository<ChefEntity, UUID> {
    Optional<ChefEntity> findByName(String name);
}
