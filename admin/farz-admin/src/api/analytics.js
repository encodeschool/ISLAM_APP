import api from './axios.js'

export const getDashboardStats = () => api.get('/api/admin/analytics/dashboard')
