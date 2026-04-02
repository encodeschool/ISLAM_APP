package uz.encode.services.mosque.dto;

import lombok.Builder;

import java.time.LocalDateTime;

@Builder
public record MosqueDTO(
        Long id,
        String name,
        String address,
        String city,
        String country,
        String phone,
        String email,
        String website,
        String description,
        String logoUrl,
        String imageUrl,
        boolean active,
        LocalDateTime createdAt
) {}
