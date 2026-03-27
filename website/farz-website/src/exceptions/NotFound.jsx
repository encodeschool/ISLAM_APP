import { Link } from "react-router-dom";

function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
      <div className="text-center">
        <h1 className="text-6xl font-bold text-green-600 mb-4">
          404
        </h1>

        <h2 className="text-2xl font-semibold mb-4">
          Page Not Found
        </h2>

        <p className="text-gray-600 mb-8">
          The page you’re looking for doesn’t exist.
        </p>

        <Link
          to="/"
          className="inline-block bg-green-600 text-white px-6 py-3 rounded-xl shadow-md hover:bg-green-700 transition"
        >
          Go Back Home
        </Link>
      </div>
    </div>
  );
}

export default NotFound;
