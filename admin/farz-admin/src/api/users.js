import api from './axios.js'

export const getUsers = () => api.get('/api/users')
export const getUserById = (id) => api.get(`/api/users/${id}`)
export const updateUser = (id, data) => api.put(`/api/users/${id}`, data)
export const deleteUser = (id) => api.delete(`/api/users/${id}`)
