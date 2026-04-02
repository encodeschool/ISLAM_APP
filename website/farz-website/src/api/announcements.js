import api from './axios';

export const getActiveAnnouncements = () =>
  api.get('/api/announcements/active');
