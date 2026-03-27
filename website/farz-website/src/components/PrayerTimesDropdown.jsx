import { useEffect, useState } from "react";

function PrayerTimesDropdown() {
  const [timings, setTimings] = useState(null);
  const [nextPrayer, setNextPrayer] = useState(null);
  const [timeLeft, setTimeLeft] = useState("");
  const [open, setOpen] = useState(false);
  const [locationName, setLocationName] = useState("");

  // 🟢 Detect Location + Fetch API
  useEffect(() => {
    navigator.geolocation.getCurrentPosition(
      async (position) => {
        const { latitude, longitude } = position.coords;

        try {
          const response = await fetch(
            `https://api.aladhan.com/v1/timings?latitude=${latitude}&longitude=${longitude}&method=3`
          );

          const data = await response.json();
          setTimings(data.data.timings);

          calculateNextPrayer(data.data.timings);

        } catch (error) {
          console.error("Error fetching prayer times", error);
        }
      },
      (error) => {
        console.error("Location permission denied", error);
      }
    );
  }, []);

  // 🟢 Calculate Next Prayer
  const calculateNextPrayer = (times) => {
    const now = new Date();
    const currentMinutes = now.getHours() * 60 + now.getMinutes();

    const prayerOrder = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];

    for (let prayer of prayerOrder) {
      const [h, m] = times[prayer].split(":").map(Number);
      const prayerMinutes = h * 60 + m;

      if (prayerMinutes > currentMinutes) {
        setNextPrayer({ name: prayer, time: times[prayer] });
        return;
      }
    }

    // If all passed → Fajr next day
    setNextPrayer({ name: "Fajr", time: times.Fajr });
  };

  // 🟢 Countdown
  useEffect(() => {
    if (!nextPrayer) return;

    const interval = setInterval(() => {
      const now = new Date();
      const [h, m] = nextPrayer.time.split(":").map(Number);

      const prayerTime = new Date();
      prayerTime.setHours(h, m, 0);

      const diff = prayerTime - now;

      if (diff > 0) {
        const hours = Math.floor(diff / (1000 * 60 * 60));
        const minutes = Math.floor((diff / (1000 * 60)) % 60);
        setTimeLeft(`-${hours}h ${minutes}m`);
      } else {
        setTimeLeft("Soon");
      }
    }, 100);

    return () => clearInterval(interval);
  }, [nextPrayer]);

  if (!timings || !nextPrayer) return null;

  return (
    <div className="relative hidden lg:block">
      {/* Next Prayer Button */}
      <button
        onClick={() => setOpen(!open)}
        className="flex items-center space-x-3 bg-green-50 px-4 py-2 rounded-full hover:bg-green-100 transition"
      >
        <span className="font-semibold text-green-700">
          {nextPrayer.name}
        </span>
        <span className="text-gray-600">
          {nextPrayer.time}
        </span>
        <span className="text-xs bg-green-200 text-green-800 px-2 py-1 rounded-full">
          {timeLeft}
        </span>
      </button>

      {/* Dropdown */}
      {open && (
        <div className="absolute right-0 mt-3 w-64 bg-white shadow-xl rounded-2xl p-4 border animate-fadeIn">
          <h4 className="font-semibold mb-3 text-gray-700">
            Today's Prayer Times
          </h4>

          {["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"].map((prayer) => (
            <div
              key={prayer}
              className={`flex justify-between py-2 px-2 rounded-lg ${
                prayer === nextPrayer.name
                  ? "bg-green-100 text-green-700 font-semibold"
                  : ""
              }`}
            >
              <span>{prayer}</span>
              <span>{timings[prayer]}</span>
            </div>
          ))}

          <div className="text-xs text-gray-400 mt-3">
            Calculation: Muslim World League
          </div>
        </div>
      )}
    </div>
  );
}

export default PrayerTimesDropdown;
