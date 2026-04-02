package uz.encode.services.mosque.dto;

public record MosqueRequest(
        String name,
        String address,
        String city,
        String country,
        String phone,
        String email,
        String website,
        String description,
        String logoUrl,
        String imageUrl
) {}
