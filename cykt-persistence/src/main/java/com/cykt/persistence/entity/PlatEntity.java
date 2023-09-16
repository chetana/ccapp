package com.cykt.persistence.entity;

import com.cykt.dto.PlatType;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.UuidGenerator;

import java.time.Instant;
import java.util.Objects;
import java.util.UUID;

@Entity
@Table(name = "plat")
@Getter
@Setter
@Builder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class PlatEntity {
    @Id
    @UuidGenerator(style = UuidGenerator.Style.TIME)
    @GeneratedValue
    private UUID id;
//    @ManyToOne
//    @JoinColumn(name = "chef_id")
//    private ChefEntity chef;
    private String name;
    @Enumerated(EnumType.STRING)
    private PlatType type;
    @Builder.Default
    private Instant createdAt = Instant.now();

//    @Override
//    public boolean equals(Object o) {
//        if (this == o) return true;
//        if (o == null || getClass() != o.getClass()) return false;
//        PlatEntity that = (PlatEntity) o;
//        return Objects.equals(id, that.id) && Objects.equals(chef, that.chef) && type == that.type && Objects.equals(createdAt, that.createdAt);
//    }
//
//    @Override
//    public int hashCode() {
//        return Objects.hash(id, chef, type, createdAt);
//    }
}
