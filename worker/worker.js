const redis = require('redis');
const express = require('express');

const app = express();
const client = redis.createClient({ url: process.env.REDIS_URL || 'redis://redis:6379' });
client.connect().catch(console.error);

let processedCount = 0;

async function processTasks() {
    while (true) {
        try {
            const taskStr = await client.rPop('queue');
            if (taskStr) {
                const task = JSON.parse(taskStr);
                
                // Simulate Heavy CPU Load so HPA scales the workers!
                const end = Date.now() + 200; // 200ms of CPU load
                while (Date.now() < end) { Math.sqrt(Math.random()); }
                
                await client.hSet(`task:${task.id}`, { status: 'completed', result: 'Success' });
                processedCount++;
            } else {
                await new Promise(resolve => setTimeout(resolve, 500));
            }
        } catch (e) {
            console.error(e);
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
    }
}

app.get('/metrics', (req, res) => {
    const cpu = process.cpuUsage();
    const cpuSeconds = (cpu.user + cpu.system) / 1e6;
    res.set('Content-Type', 'text/plain');
    res.send(`
# HELP taskflow_worker_processed_total Total tasks processed by this worker
# TYPE taskflow_worker_processed_total counter
taskflow_worker_processed_total ${processedCount}
# HELP process_cpu_seconds_total CPU usage of the worker process
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total ${cpuSeconds}
    `);
});

app.listen(5001, () => {
    console.log('Worker listening for metrics on 5001');
    processTasks();
});
