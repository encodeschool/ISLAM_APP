import Navbar from "../components/Navbar";
import Hero from "../components/Hero";
import Spiritual from "../components/Spiritual";
import PhoneShowcase from "../components/PhoneShowcase";
import Analytics from "../components/Analytics";
import DarkPreview from "../components/DarkPreview";
import CTA from "../components/CTA";
import Footer from "../components/Footer";
import FeatureCards from "../components/FeatureCards";
import Pricing from "../components/Pricing";

function Home() {
  return (
    <>
      <Navbar />
      <Hero />
      <FeatureCards />
      <Spiritual />
      <PhoneShowcase />
      <Pricing />
      {/* <Analytics />
      <DarkPreview />
      <CTA /> */}
      <Footer />
    </>
  );
}

export default Home;
