const express = require('express');
const redis = require('redis');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const client = redis.createClient({ url: process.env.REDIS_URL || 'redis://redis:6379' });
client.connect().catch(console.error);

app.post('/task', async (req, res) => {
    const id = Math.random().toString(36).substring(7);
    const { task } = req.body;
    
    // Simulate CPU Load so HPA scales the backend!
    const end = Date.now() + 50; // 50ms of CPU load
    while (Date.now() < end) { Math.sqrt(Math.random()); }
    
    // Store task state in Redis Hash
    await client.hSet(`task:${id}`, { id, task, status: 'pending', result: '' });
    // Add to list of all tasks for display
    await client.lPush('all_tasks', id);
    // Add to queue for worker
    await client.lPush('queue', JSON.stringify({ id, task }));
    
    res.json({ id, status: 'pending' });
});

app.get('/tasks', async (req, res) => {
    const ids = await client.lRange('all_tasks', 0, 19);
    const tasks = [];
    for (const id of ids) {
        const t = await client.hGetAll(`task:${id}`);
        if (t.id) tasks.push(t);
    }
    res.json(tasks);
});

app.get('/task/:id', async (req, res) => {
    const task = await client.hGetAll(`task:${req.params.id}`);
    res.json(task.id ? task : { error: 'Not found' });
});

app.delete('/tasks', async (req, res) => {
    const ids = await client.lRange('all_tasks', 0, -1);
    for (const id of ids) {
        await client.del(`task:${id}`);
    }
    await client.del('all_tasks');
    await client.del('queue'); // Optional: clear queue too
    res.json({ success: true });
});

app.get('/metrics', async (req, res) => {
    const ids = await client.lRange('all_tasks', 0, -1);
    let total = ids.length;
    let completed = 0;
    let pending = 0;
    
    for (const id of ids) {
        const status = await client.hGet(`task:${id}`, 'status');
        if (status === 'completed') completed++;
        if (status === 'pending') pending++;
    }
    
    const cpu = process.cpuUsage();
    const cpuSeconds = (cpu.user + cpu.system) / 1e6;

    res.set('Content-Type', 'text/plain');
    res.send(`
# HELP taskflow_tasks_total Total tasks
# TYPE taskflow_tasks_total gauge
taskflow_tasks_total ${total}
# HELP taskflow_tasks_completed Completed tasks
# TYPE taskflow_tasks_completed gauge
taskflow_tasks_completed ${completed}
# HELP taskflow_tasks_pending Pending tasks
# TYPE taskflow_tasks_pending gauge
taskflow_tasks_pending ${pending}
# HELP process_cpu_seconds_total CPU usage of the backend process
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total ${cpuSeconds}
    `);
});

app.listen(5000, () => console.log('Backend on 5000 (Redis persistence)'));
