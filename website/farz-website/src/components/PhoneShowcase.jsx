import { motion, useScroll } from "framer-motion";
import { useRef, useState, useEffect } from "react";
import { AnimatePresence } from "framer-motion";

import HabitImg from "../assets/img/feature1.png";
import AnalyticsImg from "../assets/img/feature2.png";
import StreakImg from "../assets/img/feature3.png";
import CommunityImg from "../assets/img/feature4.png";

import Calendar from '../assets/gifs/calendar-withoutbg.gif';
import MasjidLocation from '../assets/gifs/masjid-location.gif';
import QiblaFinder from '../assets/gifs/qibla-finder-withoutbg.gif';
import Quran from '../assets/gifs/quran-withoutbg.gif';

const features = [
  {
    title: "Track Every Salah",
    description:
      "Mark your daily prayers and build discipline with structured tracking.",
    image: HabitImg,
    icon: Calendar
  },
  {
    title: "Deep Analytics",
    description:
      "Visualize weekly, monthly and yearly performance insights.",
    image: AnalyticsImg,
    icon: MasjidLocation
  },
  {
    title: "Build Streaks",
    description:
      "Stay consistent with motivational streak tracking.",
    image: StreakImg,
    icon: QiblaFinder
  },
  {
    title: "Compete & Grow",
    description:
      "See your ranking and improve with community engagement.",
    image: CommunityImg,
    icon: Quran
  },
];

function PhoneShowcase() {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start start", "end end"],
  });

  const [activeIndex, setActiveIndex] = useState(0);

  useEffect(() => {
    return scrollYProgress.on("change", (latest) => {
      const index = Math.min(
        features.length - 1,
        Math.floor(latest * features.length)
      );
      setActiveIndex(index);
    });
  }, [scrollYProgress]);

  const activeFeature = features[activeIndex];

  return (
    <section
      id="features"
      ref={ref}
      className="relative h-[300vh] bg-gradient-to-b from-white to-green-50"
    >
      <div className="sticky top-0 h-screen flex items-center justify-center">
        <div className="max-w-6xl w-full px-6 grid md:grid-cols-2 gap-12 items-center">

          {/* TEXT SIDE */}
          <div className="relative h-64 text-center">
            <AnimatePresence mode="wait">
              <motion.div
                key={activeIndex}
                initial={{ opacity: 0, y: 40 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -40 }}
                transition={{ duration: 0.9 }}
                
              >
                <img src={activeFeature.icon} alt={activeFeature.title} className="m-auto" width="100px" />
                <h2 className="text-4xl md:text-5xl font-bold mb-6">
                  {activeFeature.title}
                </h2>
                <p className="text-gray-600 text-lg">
                  {activeFeature.description}
                </p>
              </motion.div>
            </AnimatePresence>
          </div>

          {/* PHONE SIDE */}
          <div className="relative flex justify-center">
            <AnimatePresence mode="wait">
              <motion.img
                key={activeIndex}
                src={activeFeature.image}
                alt={activeFeature.title}
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                transition={{ duration: 0.6 }}
                className="w-72 md:w-96 drop-shadow-2xl"
              />
            </AnimatePresence>
          </div>

        </div>
      </div>
    </section>
  );
}

export default PhoneShowcase;
