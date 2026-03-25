package uz.encode.services.auth.service;

import uz.encode.services.auth.dto.LoginRequest;
import uz.encode.services.auth.dto.RegisterRequest;
import uz.encode.services.auth.dto.AuthResponse;

public interface AuthService {

    AuthResponse register(RegisterRequest request);

    AuthResponse login(LoginRequest request);

}