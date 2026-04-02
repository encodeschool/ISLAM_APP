import { Link } from "react-router-dom";
import Logo from '../assets/img/logo-short.png';

function Footer() {
  return (
    <footer className="bg-gray-900 text-gray-400 pt-16 pb-8">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid md:grid-cols-4 gap-10 mb-12">
          {/* Brand */}
          <div className="md:col-span-2">
            <img src={Logo} alt="Farz" className="h-10 mb-4 brightness-200" />
            <p className="text-sm leading-relaxed text-gray-500 max-w-xs">
              Your daily companion for Salah tracking, Islamic learning, and spiritual growth.
            </p>
          </div>

          {/* Links */}
          <div>
            <h4 className="text-white text-sm font-semibold mb-4">Product</h4>
            <ul className="space-y-2 text-sm">
              <li><a href="#features" className="hover:text-white transition">Features</a></li>
              <li><a href="#download" className="hover:text-white transition">Download</a></li>
              <li><Link to="/register" className="hover:text-white transition">Get started</Link></li>
            </ul>
          </div>

          <div>
            <h4 className="text-white text-sm font-semibold mb-4">Account</h4>
            <ul className="space-y-2 text-sm">
              <li><Link to="/login" className="hover:text-white transition">Sign in</Link></li>
              <li><Link to="/register" className="hover:text-white transition">Register</Link></li>
              <li><Link to="/dashboard" className="hover:text-white transition">Dashboard</Link></li>
            </ul>
          </div>
        </div>

        <div className="border-t border-gray-800 pt-6 flex flex-col sm:flex-row justify-between items-center gap-2">
          <p className="text-xs">© {new Date().getFullYear()} Farz. All rights reserved.</p>
          <p className="text-xs">Built with ❤️ for the Muslim community</p>
        </div>
      </div>
    </footer>
  );
}

export default Footer;
