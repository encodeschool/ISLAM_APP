package uz.encode.services.analytics.dto;

public record DashboardStats(
        long totalUsers,
        long totalCourses,
        long totalMosques,
        long activeAnnouncements,
        long activeSubscriptions,
        long premiumSubscriptions,
        long basicSubscriptions
) {}
