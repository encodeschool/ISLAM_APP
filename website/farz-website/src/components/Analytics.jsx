import { motion } from "framer-motion";

function Analytics() {
  return (
    <section className="py-32 bg-green-600 text-white text-center">
      <motion.h2
        initial={{ opacity: 0, y: 40 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        className="text-5xl md:text-6xl font-bold"
      >
        See Your Progress
      </motion.h2>

      <motion.p
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        transition={{ delay: 0.4 }}
        className="mt-6 text-lg max-w-xl mx-auto"
      >
        Weekly, monthly and yearly insights to help you improve.
      </motion.p>

      <motion.img
        initial={{ opacity: 0, scale: 0.9 }}
        whileInView={{ opacity: 1, scale: 1 }}
        transition={{ delay: 0.6 }}
        src="/analytics.png"
        alt="Analytics"
        className="mx-auto mt-12 w-80 md:w-[500px]"
      />
    </section>
  );
}

export default Analytics;
