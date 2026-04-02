import { Routes, Route, Navigate } from 'react-router-dom'
import Layout from './components/layout/Layout.jsx'
import Login from './pages/Login.jsx'
import Dashboard from './pages/Dashboard.jsx'
import Users from './pages/Users.jsx'
import Courses from './pages/Courses.jsx'
import Announcements from './pages/Announcements.jsx'
import Subscriptions from './pages/Subscriptions.jsx'
import Mosques from './pages/Mosques.jsx'
import Analytics from './pages/Analytics.jsx'
import Settings from './pages/Settings.jsx'

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/" element={<Navigate to="/dashboard" replace />} />
      <Route element={<Layout />}>
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/users" element={<Users />} />
        <Route path="/courses" element={<Courses />} />
        <Route path="/announcements" element={<Announcements />} />
        <Route path="/subscriptions" element={<Subscriptions />} />
        <Route path="/mosques" element={<Mosques />} />
        <Route path="/analytics" element={<Analytics />} />
        <Route path="/settings" element={<Settings />} />
      </Route>
    </Routes>
  )
}
