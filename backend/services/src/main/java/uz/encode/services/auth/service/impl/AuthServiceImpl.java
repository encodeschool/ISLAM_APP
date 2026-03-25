package uz.encode.services.auth.service.impl;

import lombok.RequiredArgsConstructor;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import uz.encode.services.auth.dto.*;
import uz.encode.services.auth.service.AuthService;
import uz.encode.services.config.JwtService;
import uz.encode.services.user.entity.Role;
import uz.encode.services.user.entity.User;
import uz.encode.services.user.repository.UserRepository;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Override
    public AuthResponse register(RegisterRequest request) {

        User user = User.builder()
                .firstName(request.firstName())
                .lastName(request.lastName())
                .username(request.username())
                .email(request.email())
                .password(passwordEncoder.encode(request.password()))
                .role(Role.USER)
                .createdAt(LocalDateTime.now())
                .build();

        userRepository.save(user);

        String token = jwtService.generateToken(user);

        return new AuthResponse(token);
    }

    @Override
    public AuthResponse login(LoginRequest request) {

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.email(),
                        request.password()
                )
        );

        User user = userRepository
                .findByEmail(request.email())
                .orElseThrow();

        String token = jwtService.generateToken(user);

        return new AuthResponse(token);
    }

}