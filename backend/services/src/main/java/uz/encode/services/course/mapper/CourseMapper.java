package uz.encode.services.course.mapper;

import org.springframework.stereotype.Component;
import uz.encode.services.course.dto.CourseDTO;
import uz.encode.services.course.dto.LessonDTO;
import uz.encode.services.course.entity.Course;
import uz.encode.services.course.entity.Lesson;

import java.util.stream.Collectors;

@Component
public class CourseMapper {

    public CourseDTO toDto(Course course) {
        return CourseDTO.builder()
                .id(course.getId())
                .title(course.getTitle())
                .description(course.getDescription())
                .level(course.getLevel())
                .price(course.getPrice())
                .lessons(course.getLessons() != null
                        ? course.getLessons().stream().map(this::lessonToDto).collect(Collectors.toList())
                        : null)
                .build();
    }

    public LessonDTO lessonToDto(Lesson lesson) {
        return LessonDTO.builder()
                .id(lesson.getId())
                .title(lesson.getTitle())
                .content(lesson.getContent())
                .orderIndex(lesson.getOrderIndex())
                .build();
    }
}