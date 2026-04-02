import { User, Server, Palette, Shield } from 'lucide-react'
import { useAuth } from '../context/AuthContext.jsx'

function Section({ icon: Icon, title, children }) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-6">
      <div className="flex items-center gap-2 mb-5 pb-4 border-b border-gray-100">
        <div className="w-8 h-8 bg-primary-100 rounded-lg flex items-center justify-center">
          <Icon className="w-4 h-4 text-primary-700" />
        </div>
        <h2 className="text-base font-semibold text-gray-800">{title}</h2>
      </div>
      {children}
    </div>
  )
}

function InfoRow({ label, value }) {
  return (
    <div className="flex items-center justify-between py-2.5 border-b border-gray-50 last:border-0">
      <span className="text-sm text-gray-500">{label}</span>
      <span className="text-sm font-medium text-gray-800 font-mono">{value ?? '—'}</span>
    </div>
  )
}

export default function Settings() {
  const { user } = useAuth()
  const apiUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'

  return (
    <div className="max-w-2xl space-y-6">
      {/* Profile */}
      <Section icon={User} title="Profile">
        <div className="flex items-center gap-4 mb-5">
          <div className="w-14 h-14 rounded-full bg-primary-600 flex items-center justify-center text-white text-xl font-bold shadow">
            {user?.name
              ? user.name.split(' ').map((n) => n[0]).join('').toUpperCase().slice(0, 2)
              : user?.email?.[0]?.toUpperCase() || 'A'}
          </div>
          <div>
            <p className="font-semibold text-gray-800 text-lg">{user?.name || 'Admin'}</p>
            <p className="text-sm text-gray-500">{user?.email || 'admin@example.com'}</p>
          </div>
        </div>
        <InfoRow label="Name" value={user?.name} />
        <InfoRow label="Email" value={user?.email} />
        <InfoRow label="Username" value={user?.username} />
        <InfoRow label="Role" value={user?.role} />
        <InfoRow label="User ID" value={user?.id} />
      </Section>

      {/* API Configuration */}
      <Section icon={Server} title="API Configuration">
        <InfoRow label="API Base URL" value={apiUrl} />
        <InfoRow label="Environment" value={import.meta.env.MODE} />
        <InfoRow label="App Version" value="1.0.0" />
        <div className="mt-4 p-3 bg-gray-50 rounded-lg">
          <p className="text-xs text-gray-500">
            To change the API base URL, set the <code className="bg-gray-200 px-1 py-0.5 rounded text-xs">VITE_API_BASE_URL</code> environment variable in your <code className="bg-gray-200 px-1 py-0.5 rounded text-xs">.env</code> file and restart the dev server.
          </p>
        </div>
      </Section>

      {/* Security */}
      <Section icon={Shield} title="Security">
        <InfoRow label="Authentication" value="JWT Bearer Token" />
        <InfoRow label="Token Storage" value="localStorage" />
        <InfoRow label="Session" value="Persisted across refresh" />
        <div className="mt-4 p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
          <p className="text-xs text-yellow-700">
            Tokens are stored in localStorage. For production, consider using HttpOnly cookies for enhanced security.
          </p>
        </div>
      </Section>

      {/* Appearance */}
      <Section icon={Palette} title="Appearance">
        <div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg border border-gray-200">
            <div>
              <p className="text-sm font-medium text-gray-800">Theme</p>
              <p className="text-xs text-gray-500">Current color theme</p>
            </div>
            <span className="inline-flex items-center gap-2 text-sm font-medium text-gray-700">
              <span className="w-4 h-4 rounded-full bg-primary-600 ring-2 ring-primary-200 inline-block" />
              Green (Default)
            </span>
          </div>
          <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg border border-gray-200">
            <div>
              <p className="text-sm font-medium text-gray-800">Dark Mode</p>
              <p className="text-xs text-gray-500">System default</p>
            </div>
            <span className="text-xs text-gray-400 italic">Coming soon</span>
          </div>
          <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg border border-gray-200">
            <div>
              <p className="text-sm font-medium text-gray-800">Language</p>
              <p className="text-xs text-gray-500">Interface language</p>
            </div>
            <span className="text-sm font-medium text-gray-700">English</span>
          </div>
        </div>
      </Section>
    </div>
  )
}
