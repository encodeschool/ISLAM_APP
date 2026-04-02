package uz.encode.services.subscription.dto;

import uz.encode.services.subscription.entity.SubscriptionPlan;

import java.time.LocalDateTime;

public record SubscriptionRequest(
        SubscriptionPlan plan,
        LocalDateTime endDate
) {}
