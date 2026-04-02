import { useState, useEffect } from 'react'
import { toast } from 'react-hot-toast'
import { Plus, Pencil, Trash2 } from 'lucide-react'
import { getCourses, createCourse, updateCourse, deleteCourse } from '../api/courses.js'
import Table from '../components/ui/Table.jsx'
import Button from '../components/ui/Button.jsx'
import Modal from '../components/ui/Modal.jsx'
import Input from '../components/ui/Input.jsx'

const emptyForm = { title: '', description: '', lessonsCount: '' }

export default function Courses() {
  const [courses, setCourses] = useState([])
  const [loading, setLoading] = useState(true)
  const [modalOpen, setModalOpen] = useState(false)
  const [editTarget, setEditTarget] = useState(null)
  const [deleteTarget, setDeleteTarget] = useState(null)
  const [form, setForm] = useState(emptyForm)
  const [saving, setSaving] = useState(false)
  const [deleting, setDeleting] = useState(false)

  useEffect(() => { fetchCourses() }, [])

  async function fetchCourses() {
    try {
      const res = await getCourses()
      const data = res.data?.data || res.data || []
      setCourses(Array.isArray(data) ? data : [])
    } catch { toast.error('Failed to load courses') }
    finally { setLoading(false) }
  }

  function openAdd() {
    setEditTarget(null)
    setForm(emptyForm)
    setModalOpen(true)
  }

  function openEdit(course) {
    setEditTarget(course)
    setForm({
      title: course.title || '',
      description: course.description || '',
      lessonsCount: course.lessonsCount ?? '',
    })
    setModalOpen(true)
  }

  async function handleSave() {
    if (!form.title.trim()) { toast.error('Title is required'); return }
    setSaving(true)
    try {
      const payload = {
        title: form.title,
        description: form.description,
        lessonsCount: form.lessonsCount ? Number(form.lessonsCount) : undefined,
      }
      if (editTarget) {
        const res = await updateCourse(editTarget.id, payload)
        const updated = res.data?.data || res.data
        setCourses((prev) => prev.map((c) => c.id === editTarget.id ? { ...c, ...updated } : c))
        toast.success('Course updated')
      } else {
        const res = await createCourse(payload)
        const created = res.data?.data || res.data
        setCourses((prev) => [...prev, created])
        toast.success('Course created')
      }
      setModalOpen(false)
    } catch { toast.error('Failed to save course') }
    finally { setSaving(false) }
  }

  async function handleDelete() {
    if (!deleteTarget) return
    setDeleting(true)
    try {
      await deleteCourse(deleteTarget.id)
      setCourses((prev) => prev.filter((c) => c.id !== deleteTarget.id))
      toast.success('Course deleted')
      setDeleteTarget(null)
    } catch { toast.error('Failed to delete course') }
    finally { setDeleting(false) }
  }

  const columns = [
    { key: 'id', label: 'ID', render: (row) => <span className="text-gray-400 text-xs">#{row.id}</span> },
    {
      key: 'title', label: 'Title',
      render: (row) => <span className="font-medium text-gray-800">{row.title}</span>
    },
    {
      key: 'description', label: 'Description',
      render: (row) => (
        <span className="text-gray-500 text-sm max-w-xs block truncate" title={row.description}>
          {row.description || '—'}
        </span>
      )
    },
    { key: 'lessonsCount', label: 'Lessons', render: (row) => row.lessonsCount ?? '—' },
    {
      key: 'actions', label: 'Actions',
      render: (row) => (
        <div className="flex items-center gap-1">
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
          <h2 className="text-lg font-semibold text-gray-800">Courses</h2>
          <p className="text-sm text-gray-500">{courses.length} total courses</p>
        </div>
        <Button onClick={openAdd}>
          <Plus className="w-4 h-4" /> Add Course
        </Button>
      </div>

      <Table columns={columns} rows={courses} loading={loading} emptyMessage="No courses found." />

      {/* Add / Edit Modal */}
      <Modal
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
        title={editTarget ? 'Edit Course' : 'Add Course'}
        footer={
          <>
            <Button variant="secondary" onClick={() => setModalOpen(false)}>Cancel</Button>
            <Button loading={saving} onClick={handleSave}>
              {editTarget ? 'Save Changes' : 'Create Course'}
            </Button>
          </>
        }
      >
        <div className="space-y-4">
          <Input
            label="Title"
            value={form.title}
            onChange={(e) => setForm((f) => ({ ...f, title: e.target.value }))}
            placeholder="Course title"
          />
          <div className="flex flex-col gap-1">
            <label className="text-sm font-medium text-gray-700">Description</label>
            <textarea
              value={form.description}
              onChange={(e) => setForm((f) => ({ ...f, description: e.target.value }))}
              placeholder="Course description..."
              rows={3}
              className="w-full px-3 py-2 text-sm rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary-500 resize-none"
            />
          </div>
          <Input
            label="Lessons Count"
            type="number"
            value={form.lessonsCount}
            onChange={(e) => setForm((f) => ({ ...f, lessonsCount: e.target.value }))}
            placeholder="0"
            min="0"
          />
        </div>
      </Modal>

      {/* Delete confirmation */}
      <Modal
        isOpen={!!deleteTarget}
        onClose={() => setDeleteTarget(null)}
        title="Delete Course"
        footer={
          <>
            <Button variant="secondary" onClick={() => setDeleteTarget(null)}>Cancel</Button>
            <Button variant="danger" loading={deleting} onClick={handleDelete}>Delete</Button>
          </>
        }
      >
        <p className="text-gray-600">
          Delete course <strong className="text-gray-800">"{deleteTarget?.title}"</strong>? This cannot be undone.
        </p>
      </Modal>
    </div>
  )
}
