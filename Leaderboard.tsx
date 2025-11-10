"use client";
import { useEffect, useState } from "react";
import axios from "axios";

export default function Leaderboard() {
  const [leaders, setLeaders] = useState<{ address: string; cookies: number }[]>([]);

  useEffect(() => {
    axios
      .get(`${process.env.NEXT_PUBLIC_BACKEND_URL}/leaderboard`)
      .then((res) => setLeaders(res.data))
      .catch(console.error);
  }, []);

  return (
    <div className="mt-6 w-full max-w-md mx-auto bg-white/10 p-4 rounded-lg text-white backdrop-blur">
      <h2 className="text-xl font-semibold mb-3">🏆 Leaderboard</h2>
      {leaders.map((p, i) => (
        <div key={i} className="flex justify-between border-b border-white/20 py-1">
          <span className="truncate">{p.address}</span>
          <span>{p.cookies} 🍪</span>
        </div>
      ))}
    </div>
  );
}
