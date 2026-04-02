import { useState, useEffect } from 'react'
import { toast } from 'react-hot-toast'
import { Plus, Pencil, Trash2, ToggleLeft, ToggleRight } from 'lucide-react'
import { getMosques, createMosque, updateMosque, deleteMosque, toggleMosque } from '../api/mosques.js'
import Table from '../components/ui/Table.jsx'
import Button from '../components/ui/Button.jsx'
import Modal from '../components/ui/Modal.jsx'
import Input from '../components/ui/Input.jsx'
import Badge from '../components/ui/Badge.jsx'

const emptyForm = {
  name: '', address: '', city: '', country: '',
  phone: '', email: '', website: '', description: '',
  logoUrl: '', imageUrl: '',
}

export default function Mosques() {
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(true)
  const [modalOpen, setModalOpen] = useState(false)
  const [editTarget, setEditTarget] = useState(null)
  const [deleteTarget, setDeleteTarget] = useState(null)
  const [form, setForm] = useState(emptyForm)
  const [saving, setSaving] = useState(false)
  const [deleting, setDeleting] = useState(false)

  useEffect(() => { fetchItems() }, [])

  async function fetchItems() {
    try {
      const res = await getMosques()
      const data = res.data?.data || res.data || []
      setItems(Array.isArray(data) ? data : [])
    } catch { toast.error('Failed to load mosques') }
    finally { setLoading(false) }
  }

  function openAdd() {
    setEditTarget(null)
    setForm(emptyForm)
    setModalOpen(true)
  }

  function openEdit(item) {
    setEditTarget(item)
    setForm({
      name: item.name || '',
      address: item.address || '',
      city: item.city || '',
      country: item.country || '',
      phone: item.phone || '',
      email: item.email || '',
      website: item.website || '',
      description: item.description || '',
      logoUrl: item.logoUrl || '',
      imageUrl: item.imageUrl || '',
    })
    setModalOpen(true)
  }

  async function handleSave() {
    if (!form.name.trim()) { toast.error('Name is required'); return }
    setSaving(true)
    try {
      if (editTarget) {
        const res = await updateMosque(editTarget.id, form)
        const updated = res.data?.data || res.data
        setItems((prev) => prev.map((m) => m.id === editTarget.id ? { ...m, ...updated } : m))
        toast.success('Mosque updated')
      } else {
        const res = await createMosque(form)
        const created = res.data?.data || res.data
        setItems((prev) => [...prev, created])
        toast.success('Mosque created')
      }
      setModalOpen(false)
    } catch { toast.error('Failed to save mosque') }
    finally { setSaving(false) }
  }

  async function handleToggle(item) {
    try {
      await toggleMosque(item.id)
      setItems((prev) => prev.map((m) => m.id === item.id ? { ...m, active: !m.active } : m))
      toast.success(`Mosque ${item.active ? 'deactivated' : 'activated'}`)
    } catch { toast.error('Failed to toggle mosque') }
  }

  async function handleDelete() {
    if (!deleteTarget) return
    setDeleting(true)
    try {
      await deleteMosque(deleteTarget.id)
      setItems((prev) => prev.filter((m) => m.id !== deleteTarget.id))
      toast.success('Mosque deleted')
      setDeleteTarget(null)
    } catch { toast.error('Failed to delete mosque') }
    finally { setDeleting(false) }
  }

  const f = (key) => (e) => setForm((prev) => ({ ...prev, [key]: e.target.value }))

  const columns = [
    { key: 'id', label: 'ID', render: (row) => <span className="text-gray-400 text-xs">#{row.id}</span> },
    { key: 'name', label: 'Name', render: (row) => <span className="font-medium text-gray-800">{row.name}</span> },
    { key: 'city', label: 'City', render: (row) => row.city || '—' },
    { key: 'country', label: 'Country', render: (row) => row.country || '—' },
    {
      key: 'active', label: 'Status',
      render: (row) => (
        <Badge variant={row.active ? 'success' : 'default'}>
          {row.active ? 'Active' : 'Inactive'}
        </Badge>
      )
    },
    {
      key: 'createdAt', label: 'Created',
      render: (row) => row.createdAt ? new Date(row.createdAt).toLocaleDateString() : '—'
    },
    {
      key: 'actions', label: 'Actions',
      render: (row) => (
        <div className="flex items-center gap-1">
          <button
            onClick={() => handleToggle(row)}
            className={`p-1.5 rounded transition-colors ${row.active ? 'text-green-500 hover:bg-green-50' : 'text-gray-400 hover:bg-gray-100'}`}
            title={row.active ? 'Deactivate' : 'Activate'}
          >
            {row.active ? <ToggleRight className="w-4 h-4" /> : <ToggleLeft className="w-4 h-4" />}
          </button>
          <button
            onClick={() => openEdit(row)}
            className="p-1.5 text-gray-400 hover:text-primary-600 hover:bg-primary-50 rounded transition-colors"
            title="Edit"
          >
            <Pencil className="w-4 h-4" />
          </button>
          <button
            onClick={() => setDeleteTarget(row)}
            className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded transition-colors"
            title="Delete"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        </div>
      )
    },
  ]

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-lg font-semibold text-gray-800">Mosques</h2>
          <p className="text-sm text-gray-500">{items.length} total mosques</p>
        </div>
        <Button onClick={openAdd}>
          <Plus className="w-4 h-4" /> Add Mosque
        </Button>
      </div>

      <Table columns={columns} rows={items} loading={loading} emptyMessage="No mosques found." />

      {/* Add / Edit Modal */}
      <Modal
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
        title={editTarget ? 'Edit Mosque' : 'Add Mosque'}
        maxWidth="max-w-2xl"
        footer={
          <>
            <Button variant="secondary" onClick={() => setModalOpen(false)}>Cancel</Button>
            <Button loading={saving} onClick={handleSave}>
              {editTarget ? 'Save Changes' : 'Create Mosque'}
            </Button>
          </>
        }
      >
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <Input label="Name *" value={form.name} onChange={f('name')} placeholder="Mosque name" />
          <Input label="City" value={form.city} onChange={f('city')} placeholder="City" />
          <Input label="Country" value={form.country} onChange={f('country')} placeholder="Country" />
          <Input label="Phone" value={form.phone} onChange={f('phone')} placeholder="+1 234 567 890" />
          <Input label="Email" type="email" value={form.email} onChange={f('email')} placeholder="mosque@example.com" />
          <Input label="Website" value={form.website} onChange={f('website')} placeholder="https://..." />
          <div className="sm:col-span-2">
            <Input label="Address" value={form.address} onChange={f('address')} placeholder="Full street address" />
          </div>
          <Input label="Logo URL" value={form.logoUrl} onChange={f('logoUrl')} placeholder="https://..." />
          <Input label="Image URL" value={form.imageUrl} onChange={f('imageUrl')} placeholder="https://..." />
          <div className="sm:col-span-2 flex flex-col gap-1">
            <label className="text-sm font-medium text-gray-700">Description</label>
            <textarea
              value={form.description}
              onChange={f('description')}
              placeholder="Brief description..."
              rows={3}
              className="w-full px-3 py-2 text-sm rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary-500 resize-none"
            />
          </div>
        </div>
      </Modal>

      {/* Delete confirmation */}
      <Modal
        isOpen={!!deleteTarget}
        onClose={() => setDeleteTarget(null)}
        title="Delete Mosque"
        footer={
          <>
            <Button variant="secondary" onClick={() => setDeleteTarget(null)}>Cancel</Button>
            <Button variant="danger" loading={deleting} onClick={handleDelete}>Delete</Button>
          </>
        }
      >
        <p className="text-gray-600">
          Delete mosque <strong className="text-gray-800">"{deleteTarget?.name}"</strong>? This cannot be undone.
        </p>
      </Modal>
    </div>
  )
}
