const http = require('http');
const readline = require('readline');

const BACKEND_URL = 'http://localhost:5000/task';

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let globalCount = 0;

function promptUser() {
    rl.question('\nHow many requests would you like to send? (Enter a number, or Ctrl+C to exit): ', (answer) => {
        const numRequests = parseInt(answer.trim(), 10);

        if (isNaN(numRequests) || numRequests <= 0) {
            console.log("Please enter a valid positive number.");
            return promptUser();
        }

        console.log(`\n🚀 Firing ${numRequests} requests to the backend...`);

        let completed = 0;
        const startTime = Date.now();

        for (let i = 0; i < numRequests; i++) {
            const req = http.request(BACKEND_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' }
            }, (res) => {
                res.on('data', () => {}); 
                res.on('end', () => {
                    completed++;
                    if (completed === numRequests) {
                        const duration = (Date.now() - startTime) / 1000;
                        console.log(`✅ All ${numRequests} requests sent successfully in ${duration} seconds!`);
                        promptUser();
                    }
                });
            });

            req.on('error', (e) => {
                completed++;
                if (completed === numRequests) {
                    console.log(`⚠️ Finished sending requests, but some failed (Cluster might be scaling)`);
                    promptUser();
                }
            });

            req.write(JSON.stringify({ task: `Manual Stress Task ${++globalCount}` }));
            req.end();
        }
    });
}

console.log(`Starting interactive stress test against ${BACKEND_URL}`);
promptUser();
