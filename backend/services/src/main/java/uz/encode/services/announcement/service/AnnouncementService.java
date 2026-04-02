package uz.encode.services.announcement.service;

import uz.encode.services.announcement.dto.AnnouncementDTO;
import uz.encode.services.announcement.dto.AnnouncementRequest;
import uz.encode.services.announcement.entity.AnnouncementType;

import java.util.List;

public interface AnnouncementService {
    List<AnnouncementDTO> getAllAnnouncements();
    List<AnnouncementDTO> getActiveAnnouncements();
    List<AnnouncementDTO> getAnnouncementsByType(AnnouncementType type);
    AnnouncementDTO getAnnouncementById(Long id);
    AnnouncementDTO createAnnouncement(AnnouncementRequest request, Long authorId);
    AnnouncementDTO updateAnnouncement(Long id, AnnouncementRequest request);
    void deleteAnnouncement(Long id);
    AnnouncementDTO toggleActive(Long id);
}
