package uz.encode.services.user.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import uz.encode.services.user.dto.UserRequestDTO;
import uz.encode.services.user.dto.UserResponseDTO;
import uz.encode.services.user.entity.Role;
import uz.encode.services.user.entity.User;
import uz.encode.services.user.mapper.UserMapper;
import uz.encode.services.user.repository.UserRepository;
import uz.encode.services.user.service.UserService;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{
    private final UserRepository userRepository;
    private final UserMapper userMapper;

    @Override
    public UserResponseDTO getUserById(Long id) {
        return userMapper.toDto(userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found")));
    }

    @Override
    public List<UserResponseDTO> getAllUsers() {
        return userRepository.findAll().stream().map(userMapper::toDto).collect(Collectors.toList());
    }

    @Override
    public void deleteUser(Long id) {
        if (!userRepository.existsById(id)) {
            throw new RuntimeException("User not found");
        }
        
        userRepository.deleteById(id);
    }

    @Override
    public UserResponseDTO createUser(UserRequestDTO request) {
        if (userRepository.existsByEmail(request.email())) {
            throw new RuntimeException("Email already exists");
        }

        User user = User.builder()
                .username(request.username())
                .firstName(request.firstName())
                .lastName(request.lastName())
                .email(request.email())
                .password(request.password())
                .role(Role.USER)
                .createdAt(LocalDateTime.now())
                .build();

        return userMapper.toDto(userRepository.save(user));
    }

    @Override
    public UserResponseDTO updateUser(Long id, UserRequestDTO request) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        user.setUsername(request.username());
        user.setFirstName(request.firstName());
        user.setLastName(request.lastName());
        user.setEmail(request.email());

        return userMapper.toDto(userRepository.save(user));
    }

    

}
