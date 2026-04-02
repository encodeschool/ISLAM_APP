package uz.encode.services.announcement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import uz.encode.services.announcement.entity.Announcement;
import uz.encode.services.announcement.entity.AnnouncementType;

import java.util.List;

public interface AnnouncementRepository extends JpaRepository<Announcement, Long> {
    List<Announcement> findAllByOrderByPublishedAtDesc();
    List<Announcement> findByActiveTrueOrderByPublishedAtDesc();
    List<Announcement> findByTypeAndActiveTrueOrderByPublishedAtDesc(AnnouncementType type);
    long countByActiveTrue();
}
