import { createContext, useContext, useState, useEffect, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../api/axios.js'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [token, setToken] = useState(null)
  const [loading, setLoading] = useState(true)
  const navigate = useNavigate()

  useEffect(() => {
    const storedToken = localStorage.getItem('farz_token')
    const storedUser = localStorage.getItem('farz_user')
    if (storedToken && storedUser) {
      try {
        setToken(storedToken)
        setUser(JSON.parse(storedUser))
      } catch {
        localStorage.removeItem('farz_token')
        localStorage.removeItem('farz_user')
      }
    }
    setLoading(false)
  }, [])

  const login = useCallback(async (email, password) => {
    const response = await api.post('/api/auth/login', { email, password })
    const data = response.data

    // Support both wrapped { data: { token, user } } and flat { token, user }
    const payload = data.data || data
    const receivedToken = payload.token || payload.accessToken
    const receivedUser = payload.user || { email, role: payload.role || 'ADMIN' }

    localStorage.setItem('farz_token', receivedToken)
    localStorage.setItem('farz_user', JSON.stringify(receivedUser))
    setToken(receivedToken)
    setUser(receivedUser)

    return receivedUser
  }, [])

  const logout = useCallback(() => {
    localStorage.removeItem('farz_token')
    localStorage.removeItem('farz_user')
    setToken(null)
    setUser(null)
    navigate('/login')
  }, [navigate])

  const isAuthenticated = !!token

  return (
    <AuthContext.Provider value={{ user, token, login, logout, isAuthenticated, loading }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used within AuthProvider')
  return ctx
}
