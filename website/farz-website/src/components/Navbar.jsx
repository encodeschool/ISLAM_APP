import { useEffect, useState, useRef } from "react";
import { Link, useNavigate } from "react-router-dom";
import { LogOut, LayoutDashboard, ChevronDown } from "lucide-react";
import { toast } from "react-hot-toast";
import PrayerTimesDropdown from "./PrayerTimesDropdown";
import Logo from '../assets/img/logo.png';
import { useAuth } from "../context/AuthContext";

function Navbar() {
  const { isAuthenticated, user, logout } = useAuth();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const [dropdownOpen, setDropdownOpen] = useState(false);
  const dropdownRef = useRef(null);

  useEffect(() => {
    const handleScroll = () => setScrolled(window.scrollY > 40);
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
        setDropdownOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleLogout = () => {
    logout();
    toast.success("Logged out");
    navigate("/");
    setDropdownOpen(false);
    setOpen(false);
  };

  const initials = user?.email?.slice(0, 2).toUpperCase() || "U";

  return (
    <nav
      className={`fixed w-full z-50 transition-all duration-300 ${
        scrolled
          ? "bg-white/90 backdrop-blur-xl border-b border-gray-100 shadow-sm"
          : "bg-transparent"
      }`}
    >
      <div className="max-w-7xl mx-auto px-6 flex justify-between items-center h-16">
        <Link to="/">
          <img src={Logo} alt="Official Logo" width="140px" />
        </Link>

        {/* Desktop nav */}
        <div className="hidden md:flex space-x-8 items-center">
          <PrayerTimesDropdown />
          <a href="#features" className="text-sm hover:text-green-600 transition text-gray-700">
            Features
          </a>
          <a href="#download" className="text-sm hover:text-green-600 transition text-gray-700">
            Download
          </a>

          {isAuthenticated ? (
            <div className="relative" ref={dropdownRef}>
              <button
                onClick={() => setDropdownOpen(!dropdownOpen)}
                className="flex items-center gap-2 bg-green-50 hover:bg-green-100 transition px-3 py-2 rounded-xl"
              >
                <div className="w-7 h-7 rounded-full bg-green-600 text-white flex items-center justify-center text-xs font-bold">
                  {initials}
                </div>
                <span className="text-sm text-gray-700 max-w-[120px] truncate">{user?.email}</span>
                <ChevronDown
                  size={14}
                  className={`text-gray-400 transition-transform ${dropdownOpen ? "rotate-180" : ""}`}
                />
              </button>

              {dropdownOpen && (
                <div className="absolute right-0 mt-2 w-44 bg-white rounded-2xl shadow-xl border border-gray-100 py-1 overflow-hidden">
                  <Link
                    to="/dashboard"
                    onClick={() => setDropdownOpen(false)}
                    className="flex items-center gap-2 px-4 py-2.5 text-sm text-gray-700 hover:bg-green-50 hover:text-green-700 transition"
                  >
                    <LayoutDashboard size={15} /> Dashboard
                  </Link>
                  <hr className="border-gray-100 mx-2" />
                  <button
                    onClick={handleLogout}
                    className="w-full flex items-center gap-2 px-4 py-2.5 text-sm text-red-500 hover:bg-red-50 transition"
                  >
                    <LogOut size={15} /> Logout
                  </button>
                </div>
              )}
            </div>
          ) : (
            <div className="flex items-center gap-3">
              <Link
                to="/login"
                className="text-sm text-gray-700 hover:text-green-600 transition font-medium"
              >
                Sign in
              </Link>
              <Link
                to="/register"
                className="text-sm bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-xl transition font-medium shadow-sm shadow-green-200"
              >
                Get started
              </Link>
            </div>
          )}
        </div>

        {/* Mobile right side */}
        <div className="md:hidden flex items-center gap-2">
          <PrayerTimesDropdown />
          <button className="text-2xl text-gray-700 ml-1" onClick={() => setOpen(!open)}>
            {open ? "✕" : "☰"}
          </button>
        </div>
      </div>

      {/* Mobile menu */}
      {open && (
        <div className="md:hidden bg-white border-t border-gray-100 px-6 pb-6 pt-4 shadow-lg">
          <a href="#features" className="block py-3 text-gray-700 border-b border-gray-50" onClick={() => setOpen(false)}>
            Features
          </a>
          <a href="#download" className="block py-3 text-gray-700 border-b border-gray-50" onClick={() => setOpen(false)}>
            Download
          </a>

          {isAuthenticated ? (
            <>
              <Link
                to="/dashboard"
                className="flex items-center gap-2 py-3 text-green-700 border-b border-gray-50"
                onClick={() => setOpen(false)}
              >
                <LayoutDashboard size={16} /> Dashboard
              </Link>
              <button onClick={handleLogout} className="flex items-center gap-2 py-3 text-red-500 w-full">
                <LogOut size={16} /> Logout
              </button>
            </>
          ) : (
            <div className="flex gap-3 pt-4">
              <Link
                to="/login"
                className="flex-1 text-center py-2.5 rounded-xl border border-green-600 text-green-600 font-medium text-sm"
                onClick={() => setOpen(false)}
              >
                Sign in
              </Link>
              <Link
                to="/register"
                className="flex-1 text-center py-2.5 rounded-xl bg-green-600 text-white font-medium text-sm"
                onClick={() => setOpen(false)}
              >
                Get started
              </Link>
            </div>
          )}
        </div>
      )}
    </nav>
  );
}

export default Navbar;
