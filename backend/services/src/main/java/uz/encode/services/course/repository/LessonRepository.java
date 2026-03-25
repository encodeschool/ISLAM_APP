package uz.encode.services.course.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import uz.encode.services.course.entity.Lesson;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    
}
