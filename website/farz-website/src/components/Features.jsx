function Features() {
  return (
    <section id="features" className="py-20 bg-white">
      <div className="max-w-6xl mx-auto px-4 text-center">
        <h3 className="text-3xl font-bold mb-12">
          Powerful Features
        </h3>

        <div className="grid md:grid-cols-3 gap-10">
          <FeatureCard 
            title="Habit Tracker"
            text="Track each salah daily and monitor progress."
          />
          <FeatureCard 
            title="Analytics"
            text="Weekly, monthly and yearly performance insights."
          />
          <FeatureCard 
            title="Streak System"
            text="Stay consistent and grow your streak."
          />
        </div>
      </div>
    </section>
  );
}

function FeatureCard({ title, text }) {
  return (
    <div className="p-6 bg-gray-50 rounded-2xl shadow-sm hover:shadow-lg transition">
      <h4 className="text-xl font-semibold mb-4">{title}</h4>
      <p className="text-gray-600">{text}</p>
    </div>
  );
}

export default Features;
