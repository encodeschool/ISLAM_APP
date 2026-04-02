package uz.encode.services.subscription.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import uz.encode.services.common.dto.ApiResponse;
import uz.encode.services.subscription.dto.SubscriptionDTO;
import uz.encode.services.subscription.dto.SubscriptionRequest;
import uz.encode.services.subscription.service.SubscriptionService;
import uz.encode.services.user.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/subscriptions")
@RequiredArgsConstructor
@Tag(name = "Subscription API", description = "Subscription management endpoints")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;
    private final UserRepository userRepository;

    @Operation(summary = "Get all subscriptions (admin only)")
    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<List<SubscriptionDTO>>> getAllSubscriptions() {
        return ResponseEntity.ok(ApiResponse.ok(subscriptionService.getAllSubscriptions()));
    }

    @Operation(summary = "Get my active subscription")
    @GetMapping("/me")
    public ResponseEntity<ApiResponse<SubscriptionDTO>> getMySubscription(
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = getUserId(userDetails);
        Optional<SubscriptionDTO> sub = subscriptionService.getActiveSubscriptionByUserId(userId);
        return ResponseEntity.ok(ApiResponse.ok(sub.orElse(null)));
    }

    @Operation(summary = "Get subscriptions by user id (admin only)")
    @GetMapping("/user/{userId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<List<SubscriptionDTO>>> getByUserId(@PathVariable Long userId) {
        return ResponseEntity.ok(ApiResponse.ok(subscriptionService.getSubscriptionsByUserId(userId)));
    }

    @Operation(summary = "Get subscription by id (admin only)")
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<SubscriptionDTO>> getById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(subscriptionService.getSubscriptionById(id)));
    }

    @Operation(summary = "Subscribe (authenticated user)")
    @PostMapping
    public ResponseEntity<ApiResponse<SubscriptionDTO>> subscribe(
            @RequestBody SubscriptionRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = getUserId(userDetails);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.created(subscriptionService.createSubscription(userId, request)));
    }

    @Operation(summary = "Cancel subscription (admin only)")
    @PatchMapping("/{id}/cancel")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<SubscriptionDTO>> cancel(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(subscriptionService.cancelSubscription(id)));
    }

    private Long getUserId(UserDetails userDetails) {
        return userRepository.findByEmail(userDetails.getUsername())
                .map(u -> u.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));
    }
}
