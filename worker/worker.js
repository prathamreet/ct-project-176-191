const redis = require('redis');

const client = redis.createClient({ url: process.env.REDIS_URL || 'redis://redis:6379' });

async function run() {
    await client.connect();
    console.log('Worker connected (Redis mode)');
    while (true) {
        const result = await client.brPop('queue', 0);
        if (result) {
            const { id, task } = JSON.parse(result.element);
            console.log(`Processing ${id}: ${task}`);
            
            await client.hSet(`task:${id}`, 'status', 'processing');
            
            // Simulate work
            await new Promise(r => setTimeout(r, 2000));
            
            await client.hSet(`task:${id}`, 'status', 'completed');
            await client.hSet(`task:${id}`, 'result', `Processed: ${task.toUpperCase()}`);
            
            console.log(`Finished ${id}`);
        }
    }
}

run().catch(console.error);
