package uz.encode.services.announcement.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import uz.encode.services.announcement.dto.AnnouncementDTO;
import uz.encode.services.announcement.dto.AnnouncementRequest;
import uz.encode.services.announcement.entity.AnnouncementType;
import uz.encode.services.announcement.service.AnnouncementService;
import uz.encode.services.common.dto.ApiResponse;
import uz.encode.services.config.JwtService;
import uz.encode.services.user.repository.UserRepository;

import java.util.List;

@RestController
@RequestMapping("/api/announcements")
@RequiredArgsConstructor
@Tag(name = "Announcement API", description = "Announcement management endpoints")
public class AnnouncementController {

    private final AnnouncementService announcementService;
    private final JwtService jwtService;
    private final UserRepository userRepository;

    @Operation(summary = "Get all announcements (admin only)")
    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<List<AnnouncementDTO>>> getAllAnnouncements() {
        return ResponseEntity.ok(ApiResponse.ok(announcementService.getAllAnnouncements()));
    }

    @Operation(summary = "Get active announcements (public)")
    @GetMapping("/active")
    public ResponseEntity<ApiResponse<List<AnnouncementDTO>>> getActiveAnnouncements() {
        return ResponseEntity.ok(ApiResponse.ok(announcementService.getActiveAnnouncements()));
    }

    @Operation(summary = "Get active announcements by type (public)")
    @GetMapping("/active/type/{type}")
    public ResponseEntity<ApiResponse<List<AnnouncementDTO>>> getByType(@PathVariable AnnouncementType type) {
        return ResponseEntity.ok(ApiResponse.ok(announcementService.getAnnouncementsByType(type)));
    }

    @Operation(summary = "Get announcement by id")
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<AnnouncementDTO>> getById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(announcementService.getAnnouncementById(id)));
    }

    @Operation(summary = "Create announcement (admin only)")
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<AnnouncementDTO>> createAnnouncement(
            @RequestBody AnnouncementRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long authorId = userRepository.findByEmail(userDetails.getUsername())
                .map(u -> u.getId()).orElse(null);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.created(announcementService.createAnnouncement(request, authorId)));
    }

    @Operation(summary = "Update announcement (admin only)")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<AnnouncementDTO>> updateAnnouncement(
            @PathVariable Long id, @RequestBody AnnouncementRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(announcementService.updateAnnouncement(id, request)));
    }

    @Operation(summary = "Toggle announcement active status (admin only)")
    @PatchMapping("/{id}/toggle")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<AnnouncementDTO>> toggleActive(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(announcementService.toggleActive(id)));
    }

    @Operation(summary = "Delete announcement (admin only)")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> deleteAnnouncement(@PathVariable Long id) {
        announcementService.deleteAnnouncement(id);
        return ResponseEntity.ok(ApiResponse.ok(null));
    }
}
