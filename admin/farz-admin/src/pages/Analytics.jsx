import { useState, useEffect } from 'react'
import { toast } from 'react-hot-toast'
import {
  Users, BookOpen, CreditCard, Megaphone,
  Building2, TrendingUp, Activity,
} from 'lucide-react'
import {
  PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer,
  BarChart, Bar, XAxis, YAxis, CartesianGrid,
} from 'recharts'
import { getDashboardStats } from '../api/analytics.js'
import StatCard from '../components/ui/StatCard.jsx'

const PLAN_COLORS = { FREE: '#9ca3af', BASIC: '#3b82f6', PREMIUM: '#16a34a' }
const STATUS_COLORS = { ACTIVE: '#16a34a', EXPIRED: '#ef4444', CANCELLED: '#6b7280', PENDING: '#f59e0b' }

export default function Analytics() {
  const [stats, setStats] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetch() {
      try {
        const res = await getDashboardStats()
        const data = res.data?.data || res.data
        setStats(data)
      } catch { toast.error('Failed to load analytics') }
      finally { setLoading(false) }
    }
    fetch()
  }, [])

  const planData = stats
    ? [
        { name: 'FREE', value: stats.freeSubscriptions ?? stats.free ?? 0 },
        { name: 'BASIC', value: stats.basicSubscriptions ?? stats.basic ?? 0 },
        { name: 'PREMIUM', value: stats.premiumSubscriptions ?? stats.premium ?? 0 },
      ]
    : []

  const statusData = stats
    ? [
        { name: 'ACTIVE', value: stats.activeSubscriptions ?? 0 },
        { name: 'EXPIRED', value: stats.expiredSubscriptions ?? 0 },
        { name: 'CANCELLED', value: stats.cancelledSubscriptions ?? 0 },
        { name: 'PENDING', value: stats.pendingSubscriptions ?? 0 },
      ]
    : []

  const statCards = [
    { icon: Users, title: 'Total Users', key: 'totalUsers', color: 'blue' },
    { icon: BookOpen, title: 'Total Courses', key: 'totalCourses', color: 'purple' },
    { icon: Building2, title: 'Total Mosques', key: 'totalMosques', color: 'orange' },
    { icon: CreditCard, title: 'Total Subscriptions', key: 'totalSubscriptions', color: 'green' },
    { icon: CreditCard, title: 'Active Subscriptions', key: 'activeSubscriptions', color: 'green' },
    { icon: Megaphone, title: 'Active Announcements', key: 'activeAnnouncements', color: 'yellow' },
    { icon: TrendingUp, title: 'Premium Users', key: 'premiumSubscriptions', color: 'green' },
  ]

  return (
    <div className="space-y-6">
      {/* Stat cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
        {statCards.map(({ icon, title, key, color }) => (
          <StatCard
            key={key}
            icon={icon}
            title={title}
            value={loading ? null : (stats?.[key] ?? '—')}
            color={color}
            loading={loading}
          />
        ))}
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Pie: subscription plans */}
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-base font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <CreditCard className="w-4 h-4 text-primary-600" />
            Subscription Plans
          </h2>
          {loading ? (
            <div className="h-64 bg-gray-100 rounded-lg animate-pulse" />
          ) : (
            <ResponsiveContainer width="100%" height={260}>
              <PieChart>
                <Pie
                  data={planData}
                  cx="50%"
                  cy="50%"
                  outerRadius={90}
                  dataKey="value"
                  label={({ name, value }) => `${name}: ${value}`}
                  labelLine={false}
                >
                  {planData.map((entry) => (
                    <Cell key={entry.name} fill={PLAN_COLORS[entry.name] || '#9ca3af'} />
                  ))}
                </Pie>
                <Tooltip contentStyle={{ borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 12 }} />
                <Legend wrapperStyle={{ fontSize: 12 }} />
              </PieChart>
            </ResponsiveContainer>
          )}
        </div>

        {/* Bar: subscription status */}
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-base font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <Activity className="w-4 h-4 text-primary-600" />
            Subscription Status
          </h2>
          {loading ? (
            <div className="h-64 bg-gray-100 rounded-lg animate-pulse" />
          ) : (
            <ResponsiveContainer width="100%" height={260}>
              <BarChart data={statusData} margin={{ top: 5, right: 10, left: -10, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="name" tick={{ fontSize: 12 }} />
                <YAxis tick={{ fontSize: 12 }} allowDecimals={false} />
                <Tooltip contentStyle={{ borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 12 }} />
                <Bar dataKey="value" name="Count" radius={[4, 4, 0, 0]}>
                  {statusData.map((entry) => (
                    <Cell key={entry.name} fill={STATUS_COLORS[entry.name] || '#9ca3af'} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          )}
        </div>
      </div>

      {/* Summary table */}
      {!loading && stats && (
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-base font-semibold text-gray-800 mb-4">Full Summary</h2>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-200">
                  <th className="text-left py-2 text-gray-500 font-medium">Metric</th>
                  <th className="text-right py-2 text-gray-500 font-medium">Value</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {Object.entries(stats).map(([key, val]) => (
                  <tr key={key} className="hover:bg-gray-50">
                    <td className="py-2 text-gray-600 capitalize">
                      {key.replace(/([A-Z])/g, ' $1').trim()}
                    </td>
                    <td className="py-2 text-right font-medium text-gray-800">
                      {typeof val === 'object' ? JSON.stringify(val) : String(val)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  )
}
