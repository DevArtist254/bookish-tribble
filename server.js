const express = require("express");
const app = express();
const port = 3001;

app.use(express.static("public"))

app.get("/app", (req, res) => {
    res.send('Hello World');
})

app.listen(port, () => {
    console.log(`Your server is running at port ...${port}`);
});
