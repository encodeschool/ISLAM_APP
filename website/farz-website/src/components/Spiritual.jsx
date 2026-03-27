import { motion } from "framer-motion";

function Spiritual() {
  return (
    <section className="py-32 bg-white text-center">
      <motion.h2
        initial={{ opacity: 0, y: 40 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        className="text-5xl md:text-7xl font-bold leading-tight"
      >
        Consistency builds <br />
        <span className="text-green-600">discipline.</span>
      </motion.h2>

      <motion.p
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        transition={{ delay: 0.4 }}
        className="mt-8 text-lg text-gray-600 max-w-2xl mx-auto"
      >
        Your Salah journey deserves clarity, tracking and growth.
      </motion.p>
    </section>
  );
}

export default Spiritual;
