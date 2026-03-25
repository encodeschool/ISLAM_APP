package uz.encode.services.progress.mapper;

import org.springframework.stereotype.Component;
import uz.encode.services.progress.dto.ProgressDTO;
import uz.encode.services.progress.entity.Progress;

@Component
public class ProgressMapper {

    public ProgressDTO toDto(Progress progress) {
        return ProgressDTO.builder()
                .id(progress.getId())
                .userId(progress.getUser().getId())
                .lessonId(progress.getLesson().getId())
                .completed(progress.getCompleted())
                .build();
    }
}