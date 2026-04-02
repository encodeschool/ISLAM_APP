package uz.encode.services.subscription.service;

import uz.encode.services.subscription.dto.SubscriptionDTO;
import uz.encode.services.subscription.dto.SubscriptionRequest;

import java.util.List;
import java.util.Optional;

public interface SubscriptionService {
    List<SubscriptionDTO> getAllSubscriptions();
    List<SubscriptionDTO> getSubscriptionsByUserId(Long userId);
    Optional<SubscriptionDTO> getActiveSubscriptionByUserId(Long userId);
    SubscriptionDTO getSubscriptionById(Long id);
    SubscriptionDTO createSubscription(Long userId, SubscriptionRequest request);
    SubscriptionDTO cancelSubscription(Long id);
    void expireOverdueSubscriptions();
}
