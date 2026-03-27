package uz.encode.services.progress.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProgressDTO {
    private Long id;
    private Long userId;
    private Long lessonId;
    private Boolean completed;
}