package uz.encode.services.mosque.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import uz.encode.services.common.dto.ApiResponse;
import uz.encode.services.mosque.dto.MosqueDTO;
import uz.encode.services.mosque.dto.MosqueRequest;
import uz.encode.services.mosque.service.MosqueService;

import java.util.List;

@RestController
@RequestMapping("/api/mosques")
@RequiredArgsConstructor
@Tag(name = "Mosque API", description = "Mosque management endpoints")
public class MosqueController {

    private final MosqueService mosqueService;

    @Operation(summary = "Get all mosques (admin only)")
    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<List<MosqueDTO>>> getAllMosques() {
        return ResponseEntity.ok(ApiResponse.ok(mosqueService.getAllMosques()));
    }

    @Operation(summary = "Get active mosques (public)")
    @GetMapping("/active")
    public ResponseEntity<ApiResponse<List<MosqueDTO>>> getActiveMosques() {
        return ResponseEntity.ok(ApiResponse.ok(mosqueService.getActiveMosques()));
    }

    @Operation(summary = "Get mosque by id")
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<MosqueDTO>> getMosqueById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(mosqueService.getMosqueById(id)));
    }

    @Operation(summary = "Create mosque (admin only)")
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<MosqueDTO>> createMosque(@RequestBody MosqueRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.created(mosqueService.createMosque(request)));
    }

    @Operation(summary = "Update mosque (admin only)")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<MosqueDTO>> updateMosque(
            @PathVariable Long id, @RequestBody MosqueRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(mosqueService.updateMosque(id, request)));
    }

    @Operation(summary = "Toggle mosque active status (admin only)")
    @PatchMapping("/{id}/toggle")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<MosqueDTO>> toggleActive(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(mosqueService.toggleActive(id)));
    }

    @Operation(summary = "Delete mosque (admin only)")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> deleteMosque(@PathVariable Long id) {
        mosqueService.deleteMosque(id);
        return ResponseEntity.ok(ApiResponse.ok(null));
    }
}
