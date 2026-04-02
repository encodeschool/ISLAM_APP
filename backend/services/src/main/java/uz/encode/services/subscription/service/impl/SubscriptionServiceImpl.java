package uz.encode.services.subscription.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import uz.encode.services.common.exception.BadRequestException;
import uz.encode.services.common.exception.ResourceNotFoundException;
import uz.encode.services.subscription.dto.SubscriptionDTO;
import uz.encode.services.subscription.dto.SubscriptionRequest;
import uz.encode.services.subscription.entity.Subscription;
import uz.encode.services.subscription.entity.SubscriptionStatus;
import uz.encode.services.subscription.repository.SubscriptionRepository;
import uz.encode.services.subscription.service.SubscriptionService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class SubscriptionServiceImpl implements SubscriptionService {

    private final SubscriptionRepository subscriptionRepository;

    @Override
    @Transactional(readOnly = true)
    public List<SubscriptionDTO> getAllSubscriptions() {
        return subscriptionRepository.findAll().stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<SubscriptionDTO> getSubscriptionsByUserId(Long userId) {
        return subscriptionRepository.findByUserId(userId).stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<SubscriptionDTO> getActiveSubscriptionByUserId(Long userId) {
        return subscriptionRepository.findActiveByUserId(userId, LocalDateTime.now()).map(this::toDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public SubscriptionDTO getSubscriptionById(Long id) {
        return toDTO(findById(id));
    }

    @Override
    public SubscriptionDTO createSubscription(Long userId, SubscriptionRequest request) {
        subscriptionRepository.findActiveByUserId(userId, LocalDateTime.now()).ifPresent(existing -> {
            throw new BadRequestException("User already has an active subscription");
        });

        Subscription subscription = Subscription.builder()
                .userId(userId)
                .plan(request.plan())
                .status(SubscriptionStatus.ACTIVE)
                .endDate(request.endDate())
                .build();
        return toDTO(subscriptionRepository.save(subscription));
    }

    @Override
    public SubscriptionDTO cancelSubscription(Long id) {
        Subscription subscription = findById(id);
        if (subscription.getStatus() == SubscriptionStatus.CANCELLED) {
            throw new BadRequestException("Subscription is already cancelled");
        }
        subscription.setStatus(SubscriptionStatus.CANCELLED);
        return toDTO(subscriptionRepository.save(subscription));
    }

    @Override
    @Scheduled(cron = "0 0 * * * *")
    public void expireOverdueSubscriptions() {
        List<Subscription> overdue = subscriptionRepository.findOverdueSubscriptions(LocalDateTime.now());
        overdue.forEach(s -> s.setStatus(SubscriptionStatus.EXPIRED));
        subscriptionRepository.saveAll(overdue);
    }

    private Subscription findById(Long id) {
        return subscriptionRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Subscription not found with id: " + id));
    }

    private SubscriptionDTO toDTO(Subscription s) {
        return new SubscriptionDTO(
                s.getId(), s.getUserId(), s.getPlan(), s.getStatus(),
                s.getStartDate(), s.getEndDate(), s.getCreatedAt()
        );
    }
}
