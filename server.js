// server.js
const express = require('express');
const path = require('path');
const app = express();
const PORT = 3001;

// Point this to the folder your build process creates (e.g., 'dist' or 'build')
const STATIC_PATH = path.join(__dirname, 'dist');

app.use(express.static(STATIC_PATH));

// Handle SPA routing (Redirect all requests to index.html)
app.get('*', (req, res) => {
  res.sendFile(path.join(STATIC_PATH, 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running at http://localhost:${PORT}`);
  console.log(`Serving static files from: ${STATIC_PATH}`);
});
