package uz.encode.services.mosque.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import uz.encode.services.common.exception.ResourceNotFoundException;
import uz.encode.services.mosque.dto.MosqueDTO;
import uz.encode.services.mosque.dto.MosqueRequest;
import uz.encode.services.mosque.entity.Mosque;
import uz.encode.services.mosque.repository.MosqueRepository;
import uz.encode.services.mosque.service.MosqueService;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class MosqueServiceImpl implements MosqueService {

    private final MosqueRepository mosqueRepository;

    @Override
    @Transactional(readOnly = true)
    public List<MosqueDTO> getAllMosques() {
        return mosqueRepository.findAll().stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<MosqueDTO> getActiveMosques() {
        return mosqueRepository.findByActiveTrue().stream().map(this::toDTO).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public MosqueDTO getMosqueById(Long id) {
        return toDTO(findById(id));
    }

    @Override
    public MosqueDTO createMosque(MosqueRequest request) {
        Mosque mosque = Mosque.builder()
                .name(request.name())
                .address(request.address())
                .city(request.city())
                .country(request.country())
                .phone(request.phone())
                .email(request.email())
                .website(request.website())
                .description(request.description())
                .logoUrl(request.logoUrl())
                .imageUrl(request.imageUrl())
                .active(true)
                .build();
        return toDTO(mosqueRepository.save(mosque));
    }

    @Override
    public MosqueDTO updateMosque(Long id, MosqueRequest request) {
        Mosque mosque = findById(id);
        mosque.setName(request.name());
        mosque.setAddress(request.address());
        mosque.setCity(request.city());
        mosque.setCountry(request.country());
        mosque.setPhone(request.phone());
        mosque.setEmail(request.email());
        mosque.setWebsite(request.website());
        mosque.setDescription(request.description());
        mosque.setLogoUrl(request.logoUrl());
        mosque.setImageUrl(request.imageUrl());
        mosque.setUpdatedAt(LocalDateTime.now());
        return toDTO(mosqueRepository.save(mosque));
    }

    @Override
    public void deleteMosque(Long id) {
        if (!mosqueRepository.existsById(id)) {
            throw new ResourceNotFoundException("Mosque not found with id: " + id);
        }
        mosqueRepository.deleteById(id);
    }

    @Override
    public MosqueDTO toggleActive(Long id) {
        Mosque mosque = findById(id);
        mosque.setActive(!mosque.isActive());
        mosque.setUpdatedAt(LocalDateTime.now());
        return toDTO(mosqueRepository.save(mosque));
    }

    private Mosque findById(Long id) {
        return mosqueRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Mosque not found with id: " + id));
    }

    private MosqueDTO toDTO(Mosque m) {
        return new MosqueDTO(
                m.getId(), m.getName(), m.getAddress(), m.getCity(), m.getCountry(),
                m.getPhone(), m.getEmail(), m.getWebsite(), m.getDescription(),
                m.getLogoUrl(), m.getImageUrl(), m.isActive(), m.getCreatedAt()
        );
    }
}
