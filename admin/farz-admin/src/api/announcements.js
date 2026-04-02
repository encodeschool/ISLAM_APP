import api from './axios.js'

export const getAnnouncements = () => api.get('/api/announcements')
export const createAnnouncement = (data) => api.post('/api/announcements', data)
export const updateAnnouncement = (id, data) => api.put(`/api/announcements/${id}`, data)
export const deleteAnnouncement = (id) => api.delete(`/api/announcements/${id}`)
export const toggleAnnouncement = (id) => api.patch(`/api/announcements/${id}/toggle`)
