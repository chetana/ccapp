package com.cykt.dto;

import java.time.Instant;
import java.util.UUID;

public record Plat(
        Chef chef,
        String name,
        PlatType type
) {
}
