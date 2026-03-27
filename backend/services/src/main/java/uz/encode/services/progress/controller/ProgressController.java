package uz.encode.services.progress.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import uz.encode.services.progress.dto.ProgressDTO;
import uz.encode.services.progress.service.ProgressService;

import java.util.List;

@RestController
@RequestMapping("/api/progress")
@RequiredArgsConstructor
@Tag(name = "Progress API", description = "Progress management endpoints")
public class ProgressController {

    private final ProgressService progressService;

    @GetMapping("/user/{userId}")
    @Operation(summary = "Get Progress by user id")
    public ResponseEntity<List<ProgressDTO>> getProgressByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(progressService.getProgressByUser(userId));
    }

    @PostMapping("/complete")
    @Operation(summary = "Mark Lesson Completed")
    public ResponseEntity<ProgressDTO> markLessonCompleted(@RequestParam Long userId,
                                                           @RequestParam Long lessonId) {
        return ResponseEntity.ok(progressService.markLessonCompleted(userId, lessonId));
    }
}