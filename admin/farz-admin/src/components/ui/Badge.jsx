const variantMap = {
  success: 'bg-green-100 text-green-800',
  warning: 'bg-yellow-100 text-yellow-800',
  danger: 'bg-red-100 text-red-800',
  info: 'bg-blue-100 text-blue-800',
  default: 'bg-gray-100 text-gray-700',
  primary: 'bg-primary-100 text-primary-800',
}

// Map common status/plan strings to variants
function resolveVariant(status) {
  const s = (status || '').toLowerCase()
  if (['active', 'success', 'enabled', 'published', 'premium'].includes(s)) return 'success'
  if (['pending', 'warning', 'basic'].includes(s)) return 'warning'
  if (['inactive', 'expired', 'cancelled', 'danger', 'emergency'].includes(s)) return 'danger'
  if (['info', 'general', 'prayer', 'event'].includes(s)) return 'info'
  if (['admin'].includes(s)) return 'primary'
  if (['free', 'maintenance'].includes(s)) return 'default'
  return 'default'
}

export default function Badge({ children, variant, status }) {
  const resolvedVariant = variant || (status ? resolveVariant(status) : 'default')
  const styles = variantMap[resolvedVariant] || variantMap.default

  return (
    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${styles}`}>
      {children}
    </span>
  )
}
