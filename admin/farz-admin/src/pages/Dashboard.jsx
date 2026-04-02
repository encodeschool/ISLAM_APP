import { useState, useEffect } from 'react'
import { toast } from 'react-hot-toast'
import { Users, BookOpen, CreditCard, Megaphone, Activity } from 'lucide-react'
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from 'recharts'
import { getDashboardStats } from '../api/analytics.js'
import StatCard from '../components/ui/StatCard.jsx'

export default function Dashboard() {
  const [stats, setStats] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchStats() {
      try {
        const res = await getDashboardStats()
        const data = res.data?.data || res.data
        setStats(data)
      } catch (err) {
        toast.error('Failed to load dashboard stats')
        console.error(err)
      } finally {
        setLoading(false)
      }
    }
    fetchStats()
  }, [])

  // Build subscription plan chart data
  const subscriptionData = stats
    ? [
        { name: 'FREE', count: stats.freeSubscriptions ?? stats.free ?? 0, fill: '#9ca3af' },
        { name: 'BASIC', count: stats.basicSubscriptions ?? stats.basic ?? 0, fill: '#3b82f6' },
        { name: 'PREMIUM', count: stats.premiumSubscriptions ?? stats.premium ?? 0, fill: '#16a34a' },
      ]
    : []

  return (
    <div className="space-y-6">
      {/* Stat cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
        <StatCard
          icon={Users}
          title="Total Users"
          value={loading ? null : (stats?.totalUsers ?? '—')}
          color="blue"
          loading={loading}
        />
        <StatCard
          icon={BookOpen}
          title="Total Courses"
          value={loading ? null : (stats?.totalCourses ?? '—')}
          color="purple"
          loading={loading}
        />
        <StatCard
          icon={CreditCard}
          title="Active Subscriptions"
          value={loading ? null : (stats?.activeSubscriptions ?? '—')}
          color="green"
          loading={loading}
        />
        <StatCard
          icon={Megaphone}
          title="Active Announcements"
          value={loading ? null : (stats?.activeAnnouncements ?? '—')}
          color="orange"
          loading={loading}
        />
      </div>

      {/* Charts row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Subscription breakdown chart */}
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-base font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <CreditCard className="w-4 h-4 text-primary-600" />
            Subscription Plans Breakdown
          </h2>
          {loading ? (
            <div className="h-52 bg-gray-100 rounded-lg animate-pulse" />
          ) : (
            <ResponsiveContainer width="100%" height={220}>
              <BarChart data={subscriptionData} margin={{ top: 5, right: 10, left: -10, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="name" tick={{ fontSize: 12 }} />
                <YAxis tick={{ fontSize: 12 }} allowDecimals={false} />
                <Tooltip
                  contentStyle={{ borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 12 }}
                />
                <Bar dataKey="count" name="Users" radius={[4, 4, 0, 0]}>
                  {subscriptionData.map((entry, index) => (
                    <rect key={index} fill={entry.fill} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          )}
        </div>

        {/* Recent activity placeholder */}
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-base font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <Activity className="w-4 h-4 text-primary-600" />
            Recent Activity
          </h2>
          {loading ? (
            <div className="space-y-3">
              {Array.from({ length: 5 }).map((_, i) => (
                <div key={i} className="flex items-center gap-3 animate-pulse">
                  <div className="w-8 h-8 bg-gray-200 rounded-full flex-shrink-0" />
                  <div className="flex-1 space-y-1">
                    <div className="h-3 bg-gray-200 rounded w-3/4" />
                    <div className="h-3 bg-gray-200 rounded w-1/2" />
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="flex flex-col items-center justify-center h-48 text-gray-400">
              <Activity className="w-10 h-10 mb-2 opacity-30" />
              <p className="text-sm">Activity feed coming soon</p>
              <p className="text-xs mt-1 text-gray-300">Connect an activity log endpoint</p>
            </div>
          )}
        </div>
      </div>

      {/* Quick stats summary */}
      {!loading && stats && (
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-base font-semibold text-gray-800 mb-4">Platform Summary</h2>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {[
              { label: 'Total Users', value: stats.totalUsers },
              { label: 'Total Courses', value: stats.totalCourses },
              { label: 'Total Mosques', value: stats.totalMosques },
              { label: 'Active Subscriptions', value: stats.activeSubscriptions },
              { label: 'Active Announcements', value: stats.activeAnnouncements },
              { label: 'Total Subscriptions', value: stats.totalSubscriptions },
            ].map((item) => (
              <div key={item.label} className="text-center p-3 bg-gray-50 rounded-lg">
                <p className="text-xl font-bold text-gray-900">{item.value ?? '—'}</p>
                <p className="text-xs text-gray-500 mt-1">{item.label}</p>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
