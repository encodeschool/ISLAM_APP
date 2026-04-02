package uz.encode.services.subscription.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import uz.encode.services.subscription.entity.Subscription;
import uz.encode.services.subscription.entity.SubscriptionPlan;
import uz.encode.services.subscription.entity.SubscriptionStatus;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    Optional<Subscription> findByUserIdAndStatus(Long userId, SubscriptionStatus status);
    List<Subscription> findByUserId(Long userId);
    long countByStatus(SubscriptionStatus status);
    long countByPlanAndStatus(SubscriptionPlan plan, SubscriptionStatus status);

    @Query("SELECT s FROM Subscription s WHERE s.userId = :userId AND s.status = 'ACTIVE' AND (s.endDate IS NULL OR s.endDate > :now)")
    Optional<Subscription> findActiveByUserId(@Param("userId") Long userId, @Param("now") LocalDateTime now);

    @Query("SELECT s FROM Subscription s WHERE s.status = 'ACTIVE' AND s.endDate IS NOT NULL AND s.endDate <= :now")
    List<Subscription> findOverdueSubscriptions(@Param("now") LocalDateTime now);
}
