import { useState, useEffect, useMemo } from 'react'
import { toast } from 'react-hot-toast'
import { Trash2, Search } from 'lucide-react'
import { getUsers, deleteUser } from '../api/users.js'
import Table from '../components/ui/Table.jsx'
import Badge from '../components/ui/Badge.jsx'
import Button from '../components/ui/Button.jsx'
import Modal from '../components/ui/Modal.jsx'

export default function Users() {
  const [users, setUsers] = useState([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')
  const [deleteTarget, setDeleteTarget] = useState(null)
  const [deleting, setDeleting] = useState(false)

  useEffect(() => {
    fetchUsers()
  }, [])

  async function fetchUsers() {
    try {
      const res = await getUsers()
      const data = res.data?.data || res.data || []
      setUsers(Array.isArray(data) ? data : [])
    } catch {
      toast.error('Failed to load users')
    } finally {
      setLoading(false)
    }
  }

  const filtered = useMemo(() => {
    if (!search.trim()) return users
    const q = search.toLowerCase()
    return users.filter(
      (u) =>
        u.name?.toLowerCase().includes(q) ||
        u.email?.toLowerCase().includes(q) ||
        u.username?.toLowerCase().includes(q)
    )
  }, [users, search])

  async function handleDelete() {
    if (!deleteTarget) return
    setDeleting(true)
    try {
      await deleteUser(deleteTarget.id)
      toast.success('User deleted')
      setUsers((prev) => prev.filter((u) => u.id !== deleteTarget.id))
      setDeleteTarget(null)
    } catch {
      toast.error('Failed to delete user')
    } finally {
      setDeleting(false)
    }
  }

  const columns = [
    { key: 'id', label: 'ID', render: (row) => <span className="text-gray-400 text-xs">#{row.id}</span> },
    { key: 'name', label: 'Name', render: (row) => <span className="font-medium text-gray-800">{row.name || '—'}</span> },
    { key: 'email', label: 'Email' },
    { key: 'username', label: 'Username', render: (row) => row.username || '—' },
    {
      key: 'role', label: 'Role',
      render: (row) => (
        <Badge status={row.role?.toLowerCase()}>{row.role || 'USER'}</Badge>
      )
    },
    {
      key: 'createdAt', label: 'Joined',
      render: (row) => row.createdAt ? new Date(row.createdAt).toLocaleDateString() : '—'
    },
    {
      key: 'actions', label: 'Actions',
      render: (row) => (
        <button
          onClick={() => setDeleteTarget(row)}
          className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded transition-colors"
          title="Delete user"
        >
          <Trash2 className="w-4 h-4" />
        </button>
      )
    },
  ]

  return (
    <div className="space-y-4">
      {/* Toolbar */}
      <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3">
        <div>
          <h2 className="text-lg font-semibold text-gray-800">Users</h2>
          <p className="text-sm text-gray-500">{users.length} total users</p>
        </div>
        <div className="relative w-full sm:w-64">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search by name or email..."
            className="w-full pl-9 pr-4 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
          />
        </div>
      </div>

      <Table columns={columns} rows={filtered} loading={loading} emptyMessage="No users found." />

      {/* Delete confirmation modal */}
      <Modal
        isOpen={!!deleteTarget}
        onClose={() => setDeleteTarget(null)}
        title="Delete User"
        footer={
          <>
            <Button variant="secondary" onClick={() => setDeleteTarget(null)}>Cancel</Button>
            <Button variant="danger" loading={deleting} onClick={handleDelete}>Delete</Button>
          </>
        }
      >
        <p className="text-gray-600">
          Are you sure you want to delete{' '}
          <strong className="text-gray-800">{deleteTarget?.name || deleteTarget?.email}</strong>?
          This action cannot be undone.
        </p>
      </Modal>
    </div>
  )
}
