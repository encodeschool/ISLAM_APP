import { NavLink, useLocation } from 'react-router-dom'
import {
  LayoutDashboard,
  Users,
  BookOpen,
  Megaphone,
  CreditCard,
  Building2,
  BarChart2,
  Settings,
  LogOut,
  ChevronLeft,
  ChevronRight,
  X,
  Star,
} from 'lucide-react'
import { useAuth } from '../../context/AuthContext.jsx'

const navItems = [
  { path: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { path: '/users', label: 'Users', icon: Users },
  { path: '/courses', label: 'Courses', icon: BookOpen },
  { path: '/announcements', label: 'Announcements', icon: Megaphone },
  { path: '/subscriptions', label: 'Subscriptions', icon: CreditCard },
  { path: '/mosques', label: 'Mosques', icon: Building2 },
  { path: '/analytics', label: 'Analytics', icon: BarChart2 },
  { path: '/settings', label: 'Settings', icon: Settings },
]

export default function Sidebar({ isOpen, onClose, collapsed, onToggleCollapse }) {
  const { logout } = useAuth()
  const location = useLocation()

  const SidebarContent = () => (
    <div className="flex flex-col h-full bg-gray-900">
      {/* Header */}
      <div className={`flex items-center h-16 px-4 border-b border-gray-800 ${collapsed ? 'justify-center' : 'justify-between'}`}>
        {!collapsed && (
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-primary-600 rounded-lg flex items-center justify-center">
              <Star className="w-4 h-4 text-white" />
            </div>
            <span className="text-white font-bold text-lg tracking-tight">Farz Admin</span>
          </div>
        )}
        {collapsed && (
          <div className="w-8 h-8 bg-primary-600 rounded-lg flex items-center justify-center">
            <Star className="w-4 h-4 text-white" />
          </div>
        )}
        {/* Close button for mobile */}
        <button
          onClick={onClose}
          className="lg:hidden text-gray-400 hover:text-white p-1 rounded"
        >
          <X className="w-5 h-5" />
        </button>
        {/* Collapse toggle for desktop */}
        {!collapsed && (
          <button
            onClick={onToggleCollapse}
            className="hidden lg:flex text-gray-400 hover:text-white p-1 rounded hover:bg-gray-800 transition-colors"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>
        )}
      </div>

      {/* Collapsed expand button */}
      {collapsed && (
        <div className="hidden lg:flex justify-center py-2 border-b border-gray-800">
          <button
            onClick={onToggleCollapse}
            className="text-gray-400 hover:text-white p-1 rounded hover:bg-gray-800 transition-colors"
          >
            <ChevronRight className="w-5 h-5" />
          </button>
        </div>
      )}

      {/* Navigation */}
      <nav className="flex-1 overflow-y-auto py-4 px-2 space-y-1">
        {navItems.map(({ path, label, icon: Icon }) => {
          const isActive = location.pathname === path
          return (
            <NavLink
              key={path}
              to={path}
              onClick={onClose}
              title={collapsed ? label : undefined}
              className={`flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all duration-150 group
                ${collapsed ? 'justify-center' : ''}
                ${isActive
                  ? 'bg-primary-700 text-white'
                  : 'text-gray-400 hover:text-white hover:bg-gray-800'
                }`}
            >
              <Icon className="w-5 h-5 flex-shrink-0" />
              {!collapsed && <span className="text-sm font-medium">{label}</span>}
            </NavLink>
          )
        })}
      </nav>

      {/* Logout */}
      <div className="p-2 border-t border-gray-800">
        <button
          onClick={logout}
          title={collapsed ? 'Logout' : undefined}
          className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-gray-400 hover:text-red-400 hover:bg-gray-800 transition-all duration-150
            ${collapsed ? 'justify-center' : ''}`}
        >
          <LogOut className="w-5 h-5 flex-shrink-0" />
          {!collapsed && <span className="text-sm font-medium">Logout</span>}
        </button>
      </div>
    </div>
  )

  return (
    <>
      {/* Desktop sidebar */}
      <aside
        className={`hidden lg:flex flex-col flex-shrink-0 transition-all duration-300 ${collapsed ? 'w-16' : 'w-64'}`}
      >
        <SidebarContent />
      </aside>

      {/* Mobile overlay */}
      {isOpen && (
        <div className="lg:hidden fixed inset-0 z-50 flex">
          {/* Backdrop */}
          <div
            className="fixed inset-0 bg-black/60 backdrop-blur-sm"
            onClick={onClose}
          />
          {/* Drawer */}
          <aside className="relative w-64 flex flex-col z-10">
            <SidebarContent />
          </aside>
        </div>
      )}
    </>
  )
}
