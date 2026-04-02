import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Eye, EyeOff, Mail, Lock, User, AtSign } from 'lucide-react';
import { toast } from 'react-hot-toast';
import { registerApi } from '../api/auth';
import { useAuth } from '../context/AuthContext';
import { loginApi } from '../api/auth';
import Logo from '../assets/img/logo.png';

export default function Register() {
  const { login } = useAuth();
  const navigate = useNavigate();

  const [form, setForm] = useState({
    firstName: '', lastName: '', username: '', email: '', password: '', confirm: '',
  });
  const [showPass, setShowPass] = useState(false);
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({});

  const set = (field) => (e) => setForm({ ...form, [field]: e.target.value });

  const validate = () => {
    const e = {};
    if (!form.firstName.trim()) e.firstName = 'Required';
    if (!form.lastName.trim()) e.lastName = 'Required';
    if (!form.username.trim()) e.username = 'Required';
    else if (form.username.length < 3) e.username = 'At least 3 characters';
    if (!form.email) e.email = 'Required';
    else if (!/\S+@\S+\.\S+/.test(form.email)) e.email = 'Invalid email';
    if (!form.password) e.password = 'Required';
    else if (form.password.length < 6) e.password = 'At least 6 characters';
    if (form.confirm !== form.password) e.confirm = 'Passwords do not match';
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;
    setLoading(true);
    try {
      await registerApi({
        firstName: form.firstName,
        lastName: form.lastName,
        username: form.username,
        email: form.email,
        password: form.password,
      });
      await login(form.email, form.password);
      toast.success('Account created! Welcome to Farz.');
      navigate('/dashboard');
    } catch (err) {
      const msg = err.response?.data?.message || 'Registration failed. Please try again.';
      toast.error(msg);
    } finally {
      setLoading(false);
    }
  };

  const Field = ({ label, name, type = 'text', icon: Icon, placeholder, autoComplete }) => (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-1.5">{label}</label>
      <div className="relative">
        {Icon && <Icon size={15} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />}
        <input
          type={name === 'password' ? (showPass ? 'text' : 'password') : (name === 'confirm' ? (showPass ? 'text' : 'password') : type)}
          autoComplete={autoComplete}
          value={form[name]}
          onChange={set(name)}
          placeholder={placeholder}
          className={`w-full ${Icon ? 'pl-9' : 'pl-4'} ${(name === 'password' || name === 'confirm') ? 'pr-10' : 'pr-4'} py-3 rounded-xl border text-sm outline-none transition
            ${errors[name]
              ? 'border-red-400 bg-red-50 focus:ring-2 focus:ring-red-200'
              : 'border-gray-200 bg-gray-50 focus:border-green-500 focus:ring-2 focus:ring-green-100'
            }`}
        />
        {(name === 'password') && (
          <button type="button" onClick={() => setShowPass(!showPass)}
            className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
            {showPass ? <EyeOff size={15} /> : <Eye size={15} />}
          </button>
        )}
      </div>
      {errors[name] && <p className="text-red-500 text-xs mt-1">{errors[name]}</p>}
    </div>
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 via-white to-green-50 flex items-center justify-center px-4 py-12">
      <motion.div
        initial={{ opacity: 0, y: 32 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="w-full max-w-md"
      >
        <div className="bg-white rounded-3xl shadow-2xl shadow-green-100 p-8 md:p-10">
          <div className="flex justify-center mb-8">
            <Link to="/"><img src={Logo} alt="Farz" className="h-10" /></Link>
          </div>

          <h1 className="text-2xl font-bold text-gray-900 mb-1 text-center">Create your account</h1>
          <p className="text-gray-500 text-sm text-center mb-8">Start tracking your Salah journey today</p>

          <form onSubmit={handleSubmit} noValidate className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <Field label="First name" name="firstName" icon={User} placeholder="Ahmad" autoComplete="given-name" />
              <Field label="Last name" name="lastName" placeholder="Ali" autoComplete="family-name" />
            </div>
            <Field label="Username" name="username" icon={AtSign} placeholder="ahmad_ali" autoComplete="username" />
            <Field label="Email" name="email" type="email" icon={Mail} placeholder="you@example.com" autoComplete="email" />
            <Field label="Password" name="password" icon={Lock} placeholder="Min. 6 characters" autoComplete="new-password" />

            {/* Confirm password */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Confirm password</label>
              <div className="relative">
                <Lock size={15} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                <input
                  type={showPass ? 'text' : 'password'}
                  autoComplete="new-password"
                  value={form.confirm}
                  onChange={set('confirm')}
                  placeholder="Repeat password"
                  className={`w-full pl-9 pr-4 py-3 rounded-xl border text-sm outline-none transition
                    ${errors.confirm
                      ? 'border-red-400 bg-red-50 focus:ring-2 focus:ring-red-200'
                      : 'border-gray-200 bg-gray-50 focus:border-green-500 focus:ring-2 focus:ring-green-100'
                    }`}
                />
              </div>
              {errors.confirm && <p className="text-red-500 text-xs mt-1">{errors.confirm}</p>}
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-green-600 hover:bg-green-700 disabled:opacity-60 disabled:cursor-not-allowed
                text-white font-semibold py-3 rounded-xl transition duration-200 flex items-center justify-center gap-2 mt-2"
            >
              {loading && (
                <svg className="animate-spin h-4 w-4" viewBox="0 0 24 24" fill="none">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                </svg>
              )}
              {loading ? 'Creating account…' : 'Create account'}
            </button>
          </form>

          <p className="text-center text-sm text-gray-500 mt-6">
            Already have an account?{' '}
            <Link to="/login" className="text-green-600 font-medium hover:underline">Sign in</Link>
          </p>
        </div>
      </motion.div>
    </div>
  );
}
