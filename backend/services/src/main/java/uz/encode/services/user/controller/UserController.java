package uz.encode.services.user.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import uz.encode.services.user.dto.UserRequestDTO;
import uz.encode.services.user.dto.UserResponseDTO;
import uz.encode.services.user.service.UserService;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@Tag(name = "User API", description = "User management endpoints")
public class UserController {

    private final UserService userService;

    @Operation(summary = "Get all users")
    @GetMapping
    public ResponseEntity<List<UserResponseDTO>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    @Operation(summary = "Get user by id")
    @GetMapping("/{id}")
    public ResponseEntity<UserResponseDTO> getUserById(@PathVariable Long id) {
        return ResponseEntity.ok(userService.getUserById(id));
    }

    @Operation(summary = "Create new user")
    @PostMapping
    public ResponseEntity<UserResponseDTO> createUser(
            @Valid @RequestBody UserRequestDTO request) {

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(userService.createUser(request));
    }

    @Operation(summary = "Update user")
    @PutMapping("/{id}")
    public ResponseEntity<UserResponseDTO> updateUser(
            @PathVariable Long id,
            @Valid @RequestBody UserRequestDTO request) {

        return ResponseEntity.ok(userService.updateUser(id, request));
    }

    @Operation(summary = "Delete user")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {

        userService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

}