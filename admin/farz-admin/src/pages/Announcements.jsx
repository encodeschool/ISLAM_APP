import { useState, useEffect } from 'react'
import { toast } from 'react-hot-toast'
import { Plus, Pencil, Trash2, ToggleLeft, ToggleRight } from 'lucide-react'
import {
  getAnnouncements,
  createAnnouncement,
  updateAnnouncement,
  deleteAnnouncement,
  toggleAnnouncement,
} from '../api/announcements.js'
import Table from '../components/ui/Table.jsx'
import Button from '../components/ui/Button.jsx'
import Modal from '../components/ui/Modal.jsx'
import Input from '../components/ui/Input.jsx'
import Badge from '../components/ui/Badge.jsx'

const TYPES = ['GENERAL', 'PRAYER', 'EVENT', 'MAINTENANCE', 'EMERGENCY']
const emptyForm = { title: '', content: '', type: 'GENERAL', expiresAt: '' }

export default function Announcements() {
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
      const res = await getAnnouncements()
      const data = res.data?.data || res.data || []
      setItems(Array.isArray(data) ? data : [])
    } catch { toast.error('Failed to load announcements') }
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
      title: item.title || '',
      content: item.content || '',
      type: item.type || 'GENERAL',
      expiresAt: item.expiresAt ? item.expiresAt.slice(0, 16) : '',
    })
    setModalOpen(true)
  }

  async function handleSave() {
    if (!form.title.trim()) { toast.error('Title is required'); return }
    setSaving(true)
    try {
      const payload = {
        title: form.title,
        content: form.content,
        type: form.type,
        expiresAt: form.expiresAt || null,
      }
      if (editTarget) {
        const res = await updateAnnouncement(editTarget.id, payload)
        const updated = res.data?.data || res.data
        setItems((prev) => prev.map((a) => a.id === editTarget.id ? { ...a, ...updated } : a))
        toast.success('Announcement updated')
      } else {
        const res = await createAnnouncement(payload)
        const created = res.data?.data || res.data
        setItems((prev) => [...prev, created])
        toast.success('Announcement created')
      }
      setModalOpen(false)
    } catch { toast.error('Failed to save announcement') }
    finally { setSaving(false) }
  }

  async function handleToggle(item) {
    try {
      await toggleAnnouncement(item.id)
      setItems((prev) => prev.map((a) => a.id === item.id ? { ...a, active: !a.active } : a))
      toast.success(`Announcement ${item.active ? 'deactivated' : 'activated'}`)
    } catch { toast.error('Failed to toggle announcement') }
  }

  async function handleDelete() {
    if (!deleteTarget) return
    setDeleting(true)
    try {
      await deleteAnnouncement(deleteTarget.id)
      setItems((prev) => prev.filter((a) => a.id !== deleteTarget.id))
      toast.success('Announcement deleted')
      setDeleteTarget(null)
    } catch { toast.error('Failed to delete announcement') }
    finally { setDeleting(false) }
  }

  const columns = [
    { key: 'id', label: 'ID', render: (row) => <span className="text-gray-400 text-xs">#{row.id}</span> },
    { key: 'title', label: 'Title', render: (row) => <span className="font-medium text-gray-800 max-w-[180px] block truncate">{row.title}</span> },
    { key: 'type', label: 'Type', render: (row) => <Badge status={row.type?.toLowerCase()}>{row.type}</Badge> },
    {
      key: 'active', label: 'Status',
      render: (row) => (
        <Badge variant={row.active ? 'success' : 'default'}>
          {row.active ? 'Active' : 'Inactive'}
        </Badge>
      )
    },
    { key: 'author', label: 'Author', render: (row) => row.author || row.authorName || '—' },
    {
      key: 'publishedAt', label: 'Published',
      render: (row) => row.publishedAt ? new Date(row.publishedAt).toLocaleDateString() : '—'
    },
    {
      key: 'expiresAt', label: 'Expires',
      render: (row) => row.expiresAt ? new Date(row.expiresAt).toLocaleDateString() : '—'
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
          <h2 className="text-lg font-semibold text-gray-800">Announcements</h2>
          <p className="text-sm text-gray-500">{items.length} total announcements</p>
        </div>
        <Button onClick={openAdd}>
          <Plus className="w-4 h-4" /> Add Announcement
        </Button>
      </div>

      <Table columns={columns} rows={items} loading={loading} emptyMessage="No announcements found." />

      {/* Add / Edit Modal */}
      <Modal
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
        title={editTarget ? 'Edit Announcement' : 'Add Announcement'}
        maxWidth="max-w-xl"
        footer={
          <>
            <Button variant="secondary" onClick={() => setModalOpen(false)}>Cancel</Button>
            <Button loading={saving} onClick={handleSave}>
              {editTarget ? 'Save Changes' : 'Create'}
            </Button>
          </>
        }
      >
        <div className="space-y-4">
          <Input
            label="Title"
            value={form.title}
            onChange={(e) => setForm((f) => ({ ...f, title: e.target.value }))}
            placeholder="Announcement title"
          />
          <div className="flex flex-col gap-1">
            <label className="text-sm font-medium text-gray-700">Content</label>
            <textarea
              value={form.content}
              onChange={(e) => setForm((f) => ({ ...f, content: e.target.value }))}
              placeholder="Announcement content..."
              rows={4}
              className="w-full px-3 py-2 text-sm rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary-500 resize-none"
            />
          </div>
          <div className="flex flex-col gap-1">
            <label className="text-sm font-medium text-gray-700">Type</label>
            <select
              value={form.type}
              onChange={(e) => setForm((f) => ({ ...f, type: e.target.value }))}
              className="w-full px-3 py-2 text-sm rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary-500 bg-white"
            >
              {TYPES.map((t) => <option key={t} value={t}>{t}</option>)}
            </select>
          </div>
          <Input
            label="Expires At (optional)"
            type="datetime-local"
            value={form.expiresAt}
            onChange={(e) => setForm((f) => ({ ...f, expiresAt: e.target.value }))}
          />
        </div>
      </Modal>

      {/* Delete confirmation */}
      <Modal
        isOpen={!!deleteTarget}
        onClose={() => setDeleteTarget(null)}
        title="Delete Announcement"
        footer={
          <>
            <Button variant="secondary" onClick={() => setDeleteTarget(null)}>Cancel</Button>
            <Button variant="danger" loading={deleting} onClick={handleDelete}>Delete</Button>
          </>
        }
      >
        <p className="text-gray-600">
          Delete announcement <strong className="text-gray-800">"{deleteTarget?.title}"</strong>? This cannot be undone.
        </p>
      </Modal>
    </div>
  )
}
