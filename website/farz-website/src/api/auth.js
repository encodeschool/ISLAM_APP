import api from './axios';

export const loginApi = (email, password) =>
  api.post('/api/auth/login', { email, password });

export const registerApi = (data) =>
  api.post('/api/auth/register', data);
