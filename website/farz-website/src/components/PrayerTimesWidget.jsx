import { useEffect, useState } from "react";

const prayerTimes = {
  Fajr: "05:30",
  Dhuhr: "12:45",
  Asr: "16:15",
  Maghrib: "18:40",
  Isha: "20:00",
};

function getNextPrayer() {
  const now = new Date();
  const currentMinutes = now.getHours() * 60 + now.getMinutes();

  for (let [name, time] of Object.entries(prayerTimes)) {
    const [h, m] = time.split(":").map(Number);
    const prayerMinutes = h * 60 + m;

    if (prayerMinutes > currentMinutes) {
      return { name, time };
    }
  }

  // If all prayers passed → return Fajr next day
  return { name: "Fajr", time: prayerTimes.Fajr };
}

function PrayerTimesWidget() {
  const [nextPrayer, setNextPrayer] = useState(getNextPrayer());
  const [timeLeft, setTimeLeft] = useState("");

  useEffect(() => {
    const interval = setInterval(() => {
      const next = getNextPrayer();
      setNextPrayer(next);

      const now = new Date();
      const [h, m] = next.time.split(":").map(Number);
      const prayerTime = new Date();
      prayerTime.setHours(h, m, 0);

      const diff = prayerTime - now;

      if (diff > 0) {
        const hours = Math.floor(diff / (1000 * 60 * 60));
        const minutes = Math.floor((diff / (1000 * 60)) % 60);
        setTimeLeft(`${hours}h ${minutes}m`);
      } else {
        setTimeLeft("Soon");
      }
    }, 60000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="hidden lg:flex items-center space-x-4 text-sm">
      <div>
        <span className="font-semibold text-green-600">
          {nextPrayer.name}
        </span>
        <span className="ml-2 text-gray-500">
          {nextPrayer.time}
        </span>
      </div>

      <div className="bg-green-100 text-green-700 px-3 py-1 rounded-full">
        {timeLeft} left
      </div>
    </div>
  );
}

export default PrayerTimesWidget;
