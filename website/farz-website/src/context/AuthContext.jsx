import { createContext, useContext, useState, useCallback } from 'react';
import { loginApi } from '../api/auth';

const AuthContext = createContext(null);

const decodeJwt = (token) => {
  try {
    const payload = token.split('.')[1];
    return JSON.parse(atob(payload));
  } catch {
    return null;
  }
};

const loadFromStorage = () => {
  try {
    const token = localStorage.getItem('farz_token');
    const user = JSON.parse(localStorage.getItem('farz_user') || 'null');
    return { token, user };
  } catch {
    return { token: null, user: null };
  }
};

export function AuthProvider({ children }) {
  const initial = loadFromStorage();
  const [token, setToken] = useState(initial.token);
  const [user, setUser] = useState(initial.user);

  const login = useCallback(async (email, password) => {
    const res = await loginApi(email, password);
    const jwt = res.data.token;
    const claims = decodeJwt(jwt);
    const userData = {
      email: claims?.sub,
      role: claims?.role,
      userId: claims?.userId,
    };
    localStorage.setItem('farz_token', jwt);
    localStorage.setItem('farz_user', JSON.stringify(userData));
    setToken(jwt);
    setUser(userData);
    return userData;
  }, []);

  const logout = useCallback(() => {
    localStorage.removeItem('farz_token');
    localStorage.removeItem('farz_user');
    setToken(null);
    setUser(null);
  }, []);

  return (
    <AuthContext.Provider value={{ token, user, login, logout, isAuthenticated: !!token }}>
      {children}
    </AuthContext.Provider>
  );
}

export const useAuth = () => useContext(AuthContext);
