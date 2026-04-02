package uz.encode.services.mosque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import uz.encode.services.mosque.entity.Mosque;

import java.util.List;

public interface MosqueRepository extends JpaRepository<Mosque, Long> {
    List<Mosque> findByActiveTrue();
}
