package uz.encode.services.announcement.dto;

import uz.encode.services.announcement.entity.AnnouncementType;

import java.time.LocalDateTime;

public record AnnouncementRequest(
        String title,
        String content,
        AnnouncementType type,
        LocalDateTime expiresAt
) {}
