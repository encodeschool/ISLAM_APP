import { useState, useEffect } from 'react'
import { toast } from 'react-hot-toast'
import { XCircle } from 'lucide-react'
import { getSubscriptions, cancelSubscription } from '../api/subscriptions.js'
import Table from '../components/ui/Table.jsx'
import Badge from '../components/ui/Badge.jsx'
import Button from '../components/ui/Button.jsx'
import Modal from '../components/ui/Modal.jsx'

function statusVariant(status) {
  switch ((status || '').toUpperCase()) {
    case 'ACTIVE': return 'success'
    case 'EXPIRED': return 'danger'
    case 'CANCELLED': return 'default'
    case 'PENDING': return 'warning'
    default: return 'default'
  }
}

function planVariant(plan) {
  switch ((plan || '').toUpperCase()) {
    case 'PREMIUM': return 'success'
    case 'BASIC': return 'info'
    case 'FREE': return 'default'
    default: return 'default'
  }
}

export default function Subscriptions() {
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(true)
  const [cancelTarget, setCancelTarget] = useState(null)
  const [cancelling, setCancelling] = useState(false)

  useEffect(() => { fetchItems() }, [])

  async function fetchItems() {
    try {
      const res = await getSubscriptions()
      const data = res.data?.data || res.data || []
      setItems(Array.isArray(data) ? data : [])
    } catch { toast.error('Failed to load subscriptions') }
    finally { setLoading(false) }
  }

  async function handleCancel() {
    if (!cancelTarget) return
    setCancelling(true)
    try {
      await cancelSubscription(cancelTarget.id)
      setItems((prev) => prev.map((s) =>
        s.id === cancelTarget.id ? { ...s, status: 'CANCELLED' } : s
      ))
      toast.success('Subscription cancelled')
      setCancelTarget(null)
    } catch { toast.error('Failed to cancel subscription') }
    finally { setCancelling(false) }
  }

  const columns = [
    { key: 'id', label: 'ID', render: (row) => <span className="text-gray-400 text-xs">#{row.id}</span> },
    { key: 'userId', label: 'User ID', render: (row) => row.userId ?? row.user?.id ?? '—' },
    {
      key: 'plan', label: 'Plan',
      render: (row) => <Badge variant={planVariant(row.plan)}>{row.plan || '—'}</Badge>
    },
    {
      key: 'status', label: 'Status',
      render: (row) => <Badge variant={statusVariant(row.status)}>{row.status || '—'}</Badge>
    },
    {
      key: 'startDate', label: 'Start Date',
      render: (row) => row.startDate ? new Date(row.startDate).toLocaleDateString() : '—'
    },
    {
      key: 'endDate', label: 'End Date',
      render: (row) => row.endDate ? new Date(row.endDate).toLocaleDateString() : '—'
    },
    {
      key: 'actions', label: 'Actions',
      render: (row) => (
        <button
          onClick={() => setCancelTarget(row)}
          disabled={row.status === 'CANCELLED' || row.status === 'EXPIRED'}
          className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
          title="Cancel subscription"
        >
          <XCircle className="w-4 h-4" />
        </button>
      )
    },
  ]

  return (
    <div className="space-y-4">
      <div>
        <h2 className="text-lg font-semibold text-gray-800">Subscriptions</h2>
        <p className="text-sm text-gray-500">{items.length} total subscriptions</p>
      </div>

      <Table columns={columns} rows={items} loading={loading} emptyMessage="No subscriptions found." />

      {/* Cancel confirmation */}
      <Modal
        isOpen={!!cancelTarget}
        onClose={() => setCancelTarget(null)}
        title="Cancel Subscription"
        footer={
          <>
            <Button variant="secondary" onClick={() => setCancelTarget(null)}>Keep Active</Button>
            <Button variant="danger" loading={cancelling} onClick={handleCancel}>
              Cancel Subscription
            </Button>
          </>
        }
      >
        <p className="text-gray-600">
          Cancel subscription <strong className="text-gray-800">#{cancelTarget?.id}</strong>?
          The user will lose access to their plan benefits.
        </p>
      </Modal>
    </div>
  )
}
