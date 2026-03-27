import { motion, AnimatePresence } from "framer-motion";
import { useState } from "react";

function Pricing() {
  const [current, setCurrent] = useState(0);

  const plans = [
    {
      title: "Free",
      price: "$0",
      features: [
        "✔ Basic Salah Learning",
        "✔ Habit Tracker",
        "✔ Basic Analytics",
      ],
      button: "Get Started",
      highlight: false,
    },
    {
      title: "Arabic Pro",
      price: "$9.99/month",
      features: [
        "✔ Full Arabic Course",
        "✔ Word-by-word Quran Breakdown",
        "✔ Pronunciation Audio Training",
        "✔ Live Progress Tracking",
      ],
      button: "Start Learning",
      highlight: true,
    },
    {
      title: "Family Plan",
      price: "$29.99/month",
      features: [
        "✔ Full Arabic Course",
        "✔ Word-by-word Quran Breakdown",
        "✔ Pronunciation Audio Training",
        "✔ Live Progress Tracking",
      ],
      button: "Start Learning",
      highlight: false,
    },
  ];

  const nextSlide = () => {
    setCurrent((prev) => (prev + 1) % plans.length);
  };

  const prevSlide = () => {
    setCurrent((prev) =>
      prev === 0 ? plans.length - 1 : prev - 1
    );
  };

  return (
    <section className="py-32 bg-gradient-to-b from-green-50 to-white">
      <div className="max-w-7xl mx-auto px-6 text-center">

        <motion.h2
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          transition={{ duration: 0.6 }}
          className="text-4xl md:text-5xl font-bold mb-6"
        >
          Learn Arabic with Confidence
        </motion.h2>

        <p className="text-gray-600 mb-16">
          Structured Arabic learning designed for understanding Salah and Quran.
        </p>

        {/* DESKTOP GRID */}
        <div className="hidden md:grid md:grid-cols-3 gap-10">
          {plans.map((plan, index) => (
            <motion.div
              key={index}
              whileHover={{ scale: 1.05 }}
              className={`p-10 rounded-3xl shadow-xl relative ${
                plan.highlight
                  ? "bg-green-600 text-white"
                  : "bg-white text-black"
              }`}
            >
              {plan.highlight && (
                <span className="absolute top-4 right-4 bg-white text-green-600 text-xs px-3 py-1 rounded-full">
                  Most Popular
                </span>
              )}

              <h3 className="text-2xl font-semibold mb-4">
                {plan.title}
              </h3>

              <p className="text-4xl font-bold mb-6">
                {plan.price}
              </p>

              <ul className="space-y-3 mb-8">
                {plan.features.map((f, i) => (
                  <li key={i}>{f}</li>
                ))}
              </ul>

              <button
                className={`px-6 py-3 rounded-xl font-semibold transition ${
                  plan.highlight
                    ? "bg-white text-green-600 hover:bg-gray-100"
                    : "border border-green-600 text-green-600 hover:bg-green-50"
                }`}
              >
                {plan.button}
              </button>
            </motion.div>
          ))}
        </div>

        {/* MOBILE CAROUSEL */}
        <div className="md:hidden relative">

          <AnimatePresence mode="wait">
            <motion.div
              key={current}
              initial={{ opacity: 0, x: 100 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -100 }}
              transition={{ duration: 0.4 }}
              className={`p-10 rounded-3xl shadow-xl relative ${
                plans[current].highlight
                  ? "bg-green-600 text-white"
                  : "bg-white text-black"
              }`}
            >
              {plans[current].highlight && (
                <span className="absolute top-4 right-4 bg-white text-green-600 text-xs px-3 py-1 rounded-full">
                  Most Popular
                </span>
              )}

              <h3 className="text-2xl font-semibold mb-4">
                {plans[current].title}
              </h3>

              <p className="text-4xl font-bold mb-6">
                {plans[current].price}
              </p>

              <ul className="space-y-3 mb-8">
                {plans[current].features.map((f, i) => (
                  <li key={i}>{f}</li>
                ))}
              </ul>

              <button
                className={`px-6 py-3 rounded-xl font-semibold transition ${
                  plans[current].highlight
                    ? "bg-white text-green-600 hover:bg-gray-100"
                    : "border border-green-600 text-green-600 hover:bg-green-50"
                }`}
              >
                {plans[current].button}
              </button>
            </motion.div>
          </AnimatePresence>

          {/* ARROWS */}
          <div className="flex justify-between absolute top-1/2 left-0 right-0 -translate-y-1/2 px-4">
            <button
              onClick={prevSlide}
              className="bg-white shadow-md rounded-full p-2"
            >
              ←
            </button>
            <button
              onClick={nextSlide}
              className="bg-white shadow-md rounded-full p-2"
            >
              →
            </button>
          </div>

          {/* DOTS */}
          <div className="flex justify-center mt-6 space-x-2">
            {plans.map((_, index) => (
              <div
                key={index}
                onClick={() => setCurrent(index)}
                className={`h-2 w-2 rounded-full cursor-pointer ${
                  current === index
                    ? "bg-green-600"
                    : "bg-gray-300"
                }`}
              />
            ))}
          </div>

        </div>

      </div>
    </section>
  );
}

export default Pricing;