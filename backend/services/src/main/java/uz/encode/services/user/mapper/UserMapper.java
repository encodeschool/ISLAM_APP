package uz.encode.services.user.mapper;

import org.springframework.stereotype.Component;

import uz.encode.services.user.dto.UserResponseDTO;
import uz.encode.services.user.entity.User;

@Component
public class UserMapper {
    
    public UserResponseDTO toDto(User user) {
        return new UserResponseDTO(
            user.getId(),
            user.getFirstName(),
            user.getLastName(),
            user.getUsername(),
            user.getRole().name(),
            user.getCreatedAt()
        );
    }

}
