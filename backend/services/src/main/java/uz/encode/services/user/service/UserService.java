package uz.encode.services.user.service;

import java.util.List;

import uz.encode.services.user.dto.UserRequestDTO;
import uz.encode.services.user.dto.UserResponseDTO;

public interface UserService {
    
    UserResponseDTO getUserById(Long id);

    List<UserResponseDTO> getAllUsers();

    void deleteUser(Long id);

    UserResponseDTO createUser(UserRequestDTO request);

    UserResponseDTO updateUser(Long id, UserRequestDTO request);

}
