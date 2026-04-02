import api from './axios.js'

export const getMosques = () => api.get('/api/mosques')
export const createMosque = (data) => api.post('/api/mosques', data)
export const updateMosque = (id, data) => api.put(`/api/mosques/${id}`, data)
export const deleteMosque = (id) => api.delete(`/api/mosques/${id}`)
export const toggleMosque = (id) => api.patch(`/api/mosques/${id}/toggle`)
