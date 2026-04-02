import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { LogOut, Bell, Download, BookOpen, BarChart3, Star, ChevronRight, Megaphone } from 'lucide-react';
import { toast } from 'react-hot-toast';
import { useAuth } from '../context/AuthContext';
import { getActiveAnnouncements } from '../api/announcements';
import Logo from '../assets/img/logo.png';

const PRAYER_NAMES = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

const typeColors = {
  GENERAL: 'bg-blue-50 text-blue-700 border-blue-100',
  PRAYER: 'bg-green-50 text-green-700 border-green-100',
  EVENT: 'bg-purple-50 text-purple-700 border-purple-100',
  MAINTENANCE: 'bg-yellow-50 text-yellow-700 border-yellow-100',
  EMERGENCY: 'bg-red-50 text-red-700 border-red-100',
};

export default function Dashboard() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const [announcements, setAnnouncements] = useState([]);
  const [loadingAnn, setLoadingAnn] = useState(true);

  useEffect(() => {
    getActiveAnnouncements()
      .then((res) => setAnnouncements(res.data?.data || res.data || []))
      .catch(() => {})
      .finally(() => setLoadingAnn(false));
  }, []);

  const handleLogout = () => {
    logout();
    toast.success('Logged out');
    navigate('/');
  };

  const initials = user?.email?.slice(0, 2).toUpperCase() || 'U';

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 via-white to-white">
      {/* Top nav */}
      <nav className="sticky top-0 z-40 bg-white/80 backdrop-blur-xl border-b border-gray-100">
        <div className="max-w-5xl mx-auto px-6 h-16 flex items-center justify-between">
          <Link to="/"><img src={Logo} alt="Farz" className="h-8" /></Link>
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-full bg-green-600 text-white flex items-center justify-center text-sm font-bold">
              {initials}
            </div>
            <span className="text-sm text-gray-600 hidden sm:block">{user?.email}</span>
            <button
              onClick={handleLogout}
              className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-red-500 transition ml-2"
            >
              <LogOut size={15} />
              <span className="hidden sm:block">Logout</span>
            </button>
          </div>
        </div>
      </nav>

      <main className="max-w-5xl mx-auto px-6 py-10 space-y-10">
        {/* Greeting */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5 }}>
          <h1 className="text-3xl font-bold text-gray-900">
            As-salamu alaykum 👋
          </h1>
          <p className="text-gray-500 mt-1">May your prayers be accepted. Here's your overview.</p>
        </motion.div>

        {/* Today's Prayers */}
        <motion.section
          initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1, duration: 0.5 }}
        >
          <h2 className="text-lg font-semibold text-gray-800 mb-4">Today's Prayers</h2>
          <div className="grid grid-cols-5 gap-3">
            {PRAYER_NAMES.map((name, i) => (
              <div key={name} className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100 text-center hover:shadow-md transition">
                <div className="w-8 h-8 rounded-full bg-green-50 flex items-center justify-center mx-auto mb-2">
                  <span className="text-green-600 text-xs font-bold">{name[0]}</span>
                </div>
                <p className="text-xs font-semibold text-gray-700">{name}</p>
                <p className="text-xs text-gray-400 mt-1">—</p>
              </div>
            ))}
          </div>
          <p className="text-xs text-gray-400 mt-3 text-center">
            Download the Farz app to track your prayers and build streaks.
          </p>
        </motion.section>

        {/* Quick actions */}
        <motion.section
          initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2, duration: 0.5 }}
        >
          <h2 className="text-lg font-semibold text-gray-800 mb-4">Quick Access</h2>
          <div className="grid sm:grid-cols-3 gap-4">
            {[
              { icon: Download, label: 'Download App', desc: 'Get Farz on your phone', color: 'bg-green-600', href: '#download' },
              { icon: BookOpen, label: 'Learn Salah', desc: 'Step-by-step guides', color: 'bg-blue-500', href: '#features' },
              { icon: BarChart3, label: 'Analytics', desc: 'Track your progress', color: 'bg-purple-500', href: '#features' },
            ].map(({ icon: Icon, label, desc, color, href }) => (
              <Link
                key={label}
                to={href}
                className="flex items-center gap-4 bg-white rounded-2xl p-5 shadow-sm border border-gray-100 hover:shadow-md transition group"
              >
                <div className={`${color} w-11 h-11 rounded-xl flex items-center justify-center shrink-0`}>
                  <Icon size={20} className="text-white" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="font-semibold text-gray-800 text-sm">{label}</p>
                  <p className="text-xs text-gray-400 mt-0.5">{desc}</p>
                </div>
                <ChevronRight size={16} className="text-gray-300 group-hover:text-gray-500 transition shrink-0" />
              </Link>
            ))}
          </div>
        </motion.section>

        {/* Announcements */}
        <motion.section
          initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3, duration: 0.5 }}
        >
          <h2 className="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <Megaphone size={18} className="text-green-600" /> Announcements
          </h2>

          {loadingAnn ? (
            <div className="space-y-3">
              {[1, 2].map((i) => (
                <div key={i} className="bg-white rounded-2xl p-5 border border-gray-100 animate-pulse">
                  <div className="h-4 bg-gray-100 rounded w-1/3 mb-2" />
                  <div className="h-3 bg-gray-100 rounded w-2/3" />
                </div>
              ))}
            </div>
          ) : announcements.length === 0 ? (
            <div className="bg-white rounded-2xl p-6 border border-gray-100 text-center text-gray-400 text-sm">
              No announcements right now.
            </div>
          ) : (
            <div className="space-y-3">
              {announcements.map((ann) => (
                <div key={ann.id} className={`rounded-2xl p-5 border ${typeColors[ann.type] || 'bg-gray-50 text-gray-700 border-gray-100'}`}>
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <p className="font-semibold text-sm">{ann.title}</p>
                      <p className="text-sm mt-1 opacity-80">{ann.content}</p>
                    </div>
                    <span className="text-xs font-medium px-2 py-0.5 rounded-full bg-white/60 shrink-0">
                      {ann.type}
                    </span>
                  </div>
                  {ann.publishedAt && (
                    <p className="text-xs opacity-50 mt-2">
                      {new Date(ann.publishedAt).toLocaleDateString()}
                    </p>
                  )}
                </div>
              ))}
            </div>
          )}
        </motion.section>

        {/* Account */}
        <motion.section
          initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.4, duration: 0.5 }}
          className="bg-white rounded-2xl p-6 border border-gray-100 shadow-sm"
        >
          <h2 className="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <Star size={18} className="text-green-600" /> Account
          </h2>
          <div className="space-y-3 text-sm">
            <div className="flex justify-between">
              <span className="text-gray-500">Email</span>
              <span className="font-medium text-gray-800">{user?.email}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-500">Role</span>
              <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${
                user?.role === 'ADMIN' ? 'bg-purple-100 text-purple-700' : 'bg-green-100 text-green-700'
              }`}>{user?.role || 'USER'}</span>
            </div>
          </div>
        </motion.section>
      </main>
    </div>
  );
}
