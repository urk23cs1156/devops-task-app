const express = require('express');
const app = express();

app.use(express.json());

let tasks = [];

app.get('/', (req, res) => {
    res.send("DevOps Task Manager Running 🚀");
});

app.get('/tasks', (req, res) => {
    res.json(tasks);
});

app.post('/tasks', (req, res) => {
    const task = req.body.task;
    tasks.push(task);
    res.send("Task added");
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));