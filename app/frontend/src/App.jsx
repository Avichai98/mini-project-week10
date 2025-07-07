import { useEffect, useState } from "react";

const API_URL = `http://${window.location.hostname}:8000/names`;
const welcomeMessage = import.meta.env.VITE_WELCOME_MESSAGE || "Welcome to the Names List App!";

export default function App() {
  const [names, setNames] = useState([]);
  const [input, setInput] = useState("");

  useEffect(() => {
    fetchNames();
  }, []);

  const fetchNames = async () => {
    const res = await fetch(API_URL);
    const data = await res.json();
    setNames(data);
  };

  const addName = async () => {
    if (!input.trim()) return;
    await fetch(API_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name: input }),
    });
    setInput("");
    fetchNames();
  };

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        justifyContent: "flex-start", // Aligns content to the top of the flex container (main axis for column)
        alignItems: "center", // Aligns content horizontally in the center (cross axis for column)
        fontFamily: "sans-serif",
        paddingTop: "2em", // Adds a small padding at the top
        minHeight: "100vh", // Ensures the container takes at least the full viewport height
        width: "100%", // Ensures the container takes the full width
        margin: "0 auto", // Centers the div horizontally within its parent (e.g., the <body>)
        // If the <h1>, <input>, <button>, and <ul> are too wide,
        // you might want to wrap them in another div with a max-width
        // or apply specific widths to them.
      }}
    >
      <h2>{welcomeMessage}</h2> {/* Custom welcome message from environment variable */}
      <h1>👥 Names List</h1>
      <input
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        placeholder="Enter a name"
        style={{ width: "300px", marginBottom: "10px" }} // Specific width for better centering appearance
      />
      <button onClick={addName} style={{ width: "100px" }}>
        Add
      </button>
   <ul className="name-list">
  {names.map((n, i) => (
    <li key={i}>{n.name}</li>
  ))}
</ul>
    </div>
  );
}