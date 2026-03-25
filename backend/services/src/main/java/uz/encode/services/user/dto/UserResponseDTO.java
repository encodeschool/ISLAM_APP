package uz.encode.services.user.dto;

import java.time.LocalDateTime;

public record UserResponseDTO(
    Long id, 
    String firstName, 
    String lastName, 
    String username, 
    String role, 
    LocalDateTime createdAt
) {
    
}
