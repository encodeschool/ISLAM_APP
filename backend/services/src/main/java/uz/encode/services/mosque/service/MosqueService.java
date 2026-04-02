package uz.encode.services.mosque.service;

import uz.encode.services.mosque.dto.MosqueDTO;
import uz.encode.services.mosque.dto.MosqueRequest;

import java.util.List;

public interface MosqueService {
    List<MosqueDTO> getAllMosques();
    List<MosqueDTO> getActiveMosques();
    MosqueDTO getMosqueById(Long id);
    MosqueDTO createMosque(MosqueRequest request);
    MosqueDTO updateMosque(Long id, MosqueRequest request);
    void deleteMosque(Long id);
    MosqueDTO toggleActive(Long id);
}
