import React, { useState } from "react";
import axios from "axios";

function App() {
  const [form, setForm] = useState({
    name: "",
    email: ""
  });

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      await axios.post( `${import.meta.env.VITE_API_URL}/api/submit`, form);
      alert("Data submitted!");
    } catch (err) {
      console.log(err);
    }
  };

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h2>Form App hello</h2>
      <form onSubmit={handleSubmit}>
        <input
          name="name"
          placeholder="Name"
          onChange={handleChange}
        /><br /><br />

        <input
          name="email"
          placeholder="Email"
          onChange={handleChange}
        /><br /><br />

        <button type="submit">Submit</button>
        
      </form>
    </div>
  );
}

export default App;
