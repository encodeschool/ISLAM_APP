import { useEffect, useState } from "react";
import PrayerTimesDropdown from "./PrayerTimesDropdown";
import Logo from '../assets/img/logo.png';
import { CiLogin } from "react-icons/ci";

function Navbar() {
  const [open, setOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 40) {
        setScrolled(true);
      } else {
        setScrolled(false);
      }
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <nav
      className={`fixed w-full z-50 transition-all duration-50 ${
        scrolled
          ? "bg-gradient-to-br from-green-50 to-white" /* bg-white/70 backdrop-blur-xl border-b border-white/30 */
          : "bg-transparent"
      }`}
    >
      <div className="max-w-7xl mx-auto px-6 flex justify-between items-center h-16">
        <img src={Logo} alt="Official Logo" width="150px" />
        <div className="hidden md:flex space-x-8 items-center">
          <PrayerTimesDropdown />
          <a href="#features" className="hover:text-green-600 transition">
            Features
          </a>
          <a href="#download" className="hover:text-green-600 transition">
            Download
          </a>
          <a href="#login" className="flex items-center hover:text-green-600 transition">
            <CiLogin className="mr-1" /> Login
          </a>
        </div>

        <div className="md:hidden text-2xl">
          <PrayerTimesDropdown />
          <button className="text-2xl" onClick={() => setOpen(!open)}>
            ☰
          </button>
        </div>
      </div>

      {open && (
        /*bg-white/90 backdrop-blur-xl */
        <div className="md:hidden bg-gradient-to-br from-green-50 to-white px-6 pb-6 pt-4 shadow-lg">
          <a href="#features" className="block py-3">
            Features
          </a>
          <a href="#download" className="block py-3">
            Download
          </a>
          <a href="#login" className="flex items-center hover:text-green-600 transition">
            <CiLogin className="mr-1" /> Login
          </a>
        </div>
      )}
    </nav>
  );
}

export default Navbar;
