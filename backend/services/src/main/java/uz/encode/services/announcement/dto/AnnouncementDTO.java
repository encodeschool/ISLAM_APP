package uz.encode.services.announcement.dto;

import uz.encode.services.announcement.entity.AnnouncementType;

import java.time.LocalDateTime;

public record AnnouncementDTO(
        Long id,
        String title,
        String content,
        AnnouncementType type,
        boolean active,
        Long authorId,
        LocalDateTime publishedAt,
        LocalDateTime expiresAt
) {}
