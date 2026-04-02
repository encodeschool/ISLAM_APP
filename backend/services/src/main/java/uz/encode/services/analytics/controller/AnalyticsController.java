package uz.encode.services.analytics.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import uz.encode.services.analytics.dto.DashboardStats;
import uz.encode.services.announcement.repository.AnnouncementRepository;
import uz.encode.services.common.dto.ApiResponse;
import uz.encode.services.course.repository.CourseRepository;
import uz.encode.services.mosque.repository.MosqueRepository;
import uz.encode.services.subscription.entity.SubscriptionPlan;
import uz.encode.services.subscription.entity.SubscriptionStatus;
import uz.encode.services.subscription.repository.SubscriptionRepository;
import uz.encode.services.user.repository.UserRepository;

@RestController
@RequestMapping("/api/admin/analytics")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
@Tag(name = "Analytics API", description = "Admin dashboard analytics endpoints")
public class AnalyticsController {

    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final MosqueRepository mosqueRepository;
    private final AnnouncementRepository announcementRepository;
    private final SubscriptionRepository subscriptionRepository;

    @Operation(summary = "Get dashboard statistics")
    @GetMapping("/dashboard")
    public ResponseEntity<ApiResponse<DashboardStats>> getDashboardStats() {
        DashboardStats stats = new DashboardStats(
                userRepository.count(),
                courseRepository.count(),
                mosqueRepository.count(),
                announcementRepository.countByActiveTrue(),
                subscriptionRepository.countByStatus(SubscriptionStatus.ACTIVE),
                subscriptionRepository.countByPlanAndStatus(SubscriptionPlan.PREMIUM, SubscriptionStatus.ACTIVE),
                subscriptionRepository.countByPlanAndStatus(SubscriptionPlan.BASIC, SubscriptionStatus.ACTIVE)
        );
        return ResponseEntity.ok(ApiResponse.ok(stats));
    }
}
