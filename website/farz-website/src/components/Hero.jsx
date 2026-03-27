import AppPreview from '../assets/gifs/Allah-icon-withoutbg.gif';

function Hero() {
  return (
    <section className="pt-24 pb-16 bg-gradient-to-br from-green-50 to-white">
      <div className="max-w-7xl mx-auto px-6 grid md:grid-cols-2 gap-8 items-center">
        
        <div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6">
            Build Consistency in Your Salah
          </h2>
          <p className="text-gray-600 mb-6">
            Track your daily prayers, build streaks, and grow spiritually with analytics and insights.
          </p>

          <button className="bg-green-600 text-white px-6 py-3 rounded-xl shadow-md hover:bg-green-700 transition">
            Download App
          </button>
        </div>

        <div className="flex justify-center">
          <img
            src={AppPreview}
            alt="App Preview"
            className="w-72 md:w-96"
          />
        </div>
      </div>
    </section>
  );
}

export default Hero;
