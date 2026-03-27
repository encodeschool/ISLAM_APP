package uz.encode.services.progress.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uz.encode.services.progress.dto.ProgressDTO;
import uz.encode.services.progress.entity.Progress;
import uz.encode.services.progress.mapper.ProgressMapper;
import uz.encode.services.progress.repository.ProgressRepository;
import uz.encode.services.progress.service.ProgressService;
import uz.encode.services.user.repository.UserRepository;
import uz.encode.services.course.repository.LessonRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProgressServiceImpl implements ProgressService {

    private final ProgressRepository progressRepository;
    private final ProgressMapper progressMapper;
    private final UserRepository userRepository;
    private final LessonRepository lessonRepository;

    @Override
    public List<ProgressDTO> getProgressByUser(Long userId) {
        return progressRepository.findByUserId(userId)
                .stream()
                .map(progressMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public ProgressDTO markLessonCompleted(Long userId, Long lessonId) {

        var user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        var lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new RuntimeException("Lesson not found"));

        Progress progress = Progress.builder()
                .user(user)
                .lesson(lesson)
                .completed(true)
                .completedAt(LocalDateTime.now())
                .build();

        return progressMapper.toDto(progressRepository.save(progress));
    }
}