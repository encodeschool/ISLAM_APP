package uz.encode.services.course.dto;

import lombok.*;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CourseDTO {
    private Long id;
    private String title;
    private String description;
    private String level;
    private Double price;
    private List<LessonDTO> lessons;
}