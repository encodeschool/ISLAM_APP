package uz.encode.services.subscription.dto;

import uz.encode.services.subscription.entity.SubscriptionPlan;
import uz.encode.services.subscription.entity.SubscriptionStatus;

import java.time.LocalDateTime;

public record SubscriptionDTO(
        Long id,
        Long userId,
        SubscriptionPlan plan,
        SubscriptionStatus status,
        LocalDateTime startDate,
        LocalDateTime endDate,
        LocalDateTime createdAt
) {}
