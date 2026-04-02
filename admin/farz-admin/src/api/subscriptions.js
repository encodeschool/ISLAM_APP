import api from './axios.js'

export const getSubscriptions = () => api.get('/api/subscriptions')
export const cancelSubscription = (id) => api.patch(`/api/subscriptions/${id}/cancel`)
