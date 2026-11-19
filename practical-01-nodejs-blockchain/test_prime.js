const { Blockchain } = require('./prime_blockchain');

let primeChain = new Blockchain();
primeChain.addBlockIfPrime(7);  // Prime, will be added
primeChain.addBlockIfPrime(10); // Not prime, will be rejected
primeChain.addBlockIfPrime(13); // Prime, will be added
console.log("\n--- Final Prime Blockchain ---");
console.log(JSON.stringify(primeChain, null, 4));
