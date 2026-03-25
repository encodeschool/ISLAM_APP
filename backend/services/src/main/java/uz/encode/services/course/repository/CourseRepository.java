package uz.encode.services.course.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import uz.encode.services.course.entity.Course;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    
}
