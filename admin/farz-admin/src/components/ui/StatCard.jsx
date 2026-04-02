import { TrendingUp, TrendingDown } from 'lucide-react'

const colorMap = {
  green: 'bg-green-100 text-green-600',
  blue: 'bg-blue-100 text-blue-600',
  purple: 'bg-purple-100 text-purple-600',
  orange: 'bg-orange-100 text-orange-600',
  red: 'bg-red-100 text-red-600',
  yellow: 'bg-yellow-100 text-yellow-600',
}

export default function StatCard({ icon: Icon, title, value, trend, color = 'green', loading = false }) {
  const iconStyles = colorMap[color] || colorMap.green

  if (loading) {
    return (
      <div className="bg-white rounded-xl border border-gray-200 p-5 animate-pulse">
        <div className="flex items-center justify-between mb-4">
          <div className="w-10 h-10 bg-gray-200 rounded-lg" />
          <div className="w-16 h-4 bg-gray-200 rounded" />
        </div>
        <div className="w-24 h-7 bg-gray-200 rounded mb-1" />
        <div className="w-32 h-4 bg-gray-200 rounded" />
      </div>
    )
  }

  return (
    <div className="bg-white rounded-xl border border-gray-200 p-5 hover:shadow-md transition-shadow">
      <div className="flex items-start justify-between mb-4">
        <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${iconStyles}`}>
          {Icon && <Icon className="w-5 h-5" />}
        </div>
        {trend !== undefined && trend !== null && (
          <div className={`flex items-center gap-1 text-xs font-medium ${trend >= 0 ? 'text-green-600' : 'text-red-600'}`}>
            {trend >= 0
              ? <TrendingUp className="w-3.5 h-3.5" />
              : <TrendingDown className="w-3.5 h-3.5" />
            }
            {Math.abs(trend)}%
          </div>
        )}
      </div>
      <p className="text-2xl font-bold text-gray-900 mb-1">{value ?? '—'}</p>
      <p className="text-sm text-gray-500">{title}</p>
    </div>
  )
}
