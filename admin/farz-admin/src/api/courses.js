import api from './axios.js'

export const getCourses = () => api.get('/api/courses')
export const createCourse = (data) => api.post('/api/courses', data)
export const updateCourse = (id, data) => api.put(`/api/courses/${id}`, data)
export const deleteCourse = (id) => api.delete(`/api/courses/${id}`)
