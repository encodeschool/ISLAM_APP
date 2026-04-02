package uz.encode.services.user.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UserRequestDTO(

    @NotBlank
    String firstName,

    @NotBlank
    String lastName,

    @NotBlank
    @Size(min = 3, max = 50)
    String username, 

    @NotBlank
    @Email
    String email,
    
    @Size(min = 6)
    String password,

    String role
    
) {
    
}
