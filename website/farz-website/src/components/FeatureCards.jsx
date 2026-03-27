import { motion } from "framer-motion";
import {
  BarChart3,
  CalendarCheck,
  Flame,
  Users,
  BookOpen,
  Bell,
} from "lucide-react";

const features = [
  {
    icon: <CalendarCheck size={28} />,
    title: "Daily Salah Tracker",
    desc: "Mark every prayer and build consistency daily.",
  },
  {
    icon: <BarChart3 size={28} />,
    title: "Advanced Analytics",
    desc: "Track weekly, monthly and yearly progress.",
  },
  {
    icon: <Flame size={28} />,
    title: "Streak System",
    desc: "Stay motivated with daily streak tracking.",
  },
  {
    icon: <Users size={28} />,
    title: "Community Ranking",
    desc: "See how you compare and grow together.",
  },
  {
    icon: <BookOpen size={28} />,
    title: "Learn Salah Step-by-Step",
    desc: "Interactive guides with images and audio.",
  },
  {
    icon: <Bell size={28} />,
    title: "Smart Reminders",
    desc: "Never miss a prayer again.",
  },
];

function FeatureCards() {
  return (
    <section className="py-32 bg-white">
      <div className="max-w-7xl mx-auto px-6 text-center">
        <motion.h2
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="text-4xl md:text-5xl font-bold mb-16"
        >
          Everything You Need to Improve
        </motion.h2>

        <div className="grid md:grid-cols-3 gap-10">
          {features.map((feature, index) => (
            <motion.div
              key={index}
              whileHover={{ y: -10 }}
              className="p-8 rounded-3xl bg-gray-50 shadow-sm hover:shadow-xl transition"
            >
              <div className="text-green-600 mb-4 flex justify-center">
                {feature.icon}
              </div>

              <h3 className="text-xl font-semibold mb-3">
                {feature.title}
              </h3>

              <p className="text-gray-600">
                {feature.desc}
              </p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}

export default FeatureCards;
