package uz.encode.services.announcement.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import uz.encode.services.announcement.dto.AnnouncementDTO;
import uz.encode.services.announcement.dto.AnnouncementRequest;
import uz.encode.services.announcement.entity.Announcement;
import uz.encode.services.announcement.entity.AnnouncementType;
import uz.encode.services.announcement.repository.AnnouncementRepository;
import uz.encode.services.announcement.service.AnnouncementService;
import uz.encode.services.common.exception.ResourceNotFoundException;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AnnouncementServiceImpl implements AnnouncementService {

    private final AnnouncementRepository announcementRepository;

    @Override
    @Transactional(readOnly = true)
    public List<AnnouncementDTO> getAllAnnouncements() {
        return announcementRepository.findAllByOrderByPublishedAtDesc().stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<AnnouncementDTO> getActiveAnnouncements() {
        return announcementRepository.findByActiveTrueOrderByPublishedAtDesc().stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<AnnouncementDTO> getAnnouncementsByType(AnnouncementType type) {
        return announcementRepository.findByTypeAndActiveTrueOrderByPublishedAtDesc(type).stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public AnnouncementDTO getAnnouncementById(Long id) {
        return toDTO(findById(id));
    }

    @Override
    public AnnouncementDTO createAnnouncement(AnnouncementRequest request, Long authorId) {
        Announcement announcement = Announcement.builder()
                .title(request.title())
                .content(request.content())
                .type(request.type())
                .expiresAt(request.expiresAt())
                .authorId(authorId)
                .active(true)
                .build();
        return toDTO(announcementRepository.save(announcement));
    }

    @Override
    public AnnouncementDTO updateAnnouncement(Long id, AnnouncementRequest request) {
        Announcement announcement = findById(id);
        announcement.setTitle(request.title());
        announcement.setContent(request.content());
        announcement.setType(request.type());
        announcement.setExpiresAt(request.expiresAt());
        return toDTO(announcementRepository.save(announcement));
    }

    @Override
    public void deleteAnnouncement(Long id) {
        if (!announcementRepository.existsById(id)) {
            throw new ResourceNotFoundException("Announcement not found with id: " + id);
        }
        announcementRepository.deleteById(id);
    }

    @Override
    public AnnouncementDTO toggleActive(Long id) {
        Announcement announcement = findById(id);
        announcement.setActive(!announcement.isActive());
        return toDTO(announcementRepository.save(announcement));
    }

    private Announcement findById(Long id) {
        return announcementRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Announcement not found with id: " + id));
    }

    private AnnouncementDTO toDTO(Announcement a) {
        return new AnnouncementDTO(
                a.getId(), a.getTitle(), a.getContent(), a.getType(),
                a.isActive(), a.getAuthorId(), a.getPublishedAt(), a.getExpiresAt()
        );
    }
}
