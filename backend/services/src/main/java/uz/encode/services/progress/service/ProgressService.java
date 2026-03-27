package uz.encode.services.progress.service;

import uz.encode.services.progress.dto.ProgressDTO;

import java.util.List;

public interface ProgressService {

    List<ProgressDTO> getProgressByUser(Long userId);

    ProgressDTO markLessonCompleted(Long userId, Long lessonId);
}