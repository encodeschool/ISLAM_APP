package uz.encode.services.course.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LessonDTO {
    private Long id;
    private String title;
    private String content;
    private Integer orderIndex;
}