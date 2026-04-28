// server.js
const express = require('express');
const app = express();
const PORT = 3002;

app.use(express.static('public'));

app.get('/app', (req, res) => {
    res.send('Hello World');
});

app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});
