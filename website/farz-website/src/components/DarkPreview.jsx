import { motion } from "framer-motion";

function DarkPreview() {
  return (
    <section className="py-32 bg-black text-white text-center">
      <motion.h2
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        transition={{ duration: 0.8 }}
        className="text-5xl md:text-6xl font-bold"
      >
        Beautiful in the Dark.
      </motion.h2>

      <motion.img
        initial={{ opacity: 0, y: 40 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.4 }}
        src="/dark-preview.png"
        alt="Dark Mode"
        className="mx-auto mt-12 w-72 md:w-96"
      />
    </section>
  );
}

export default DarkPreview;
