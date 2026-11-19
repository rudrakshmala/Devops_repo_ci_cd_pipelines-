const crypto = require('crypto');

function isPrime(num) {
    if (num <= 1) return false;
    for (let i = 2; i <= Math.sqrt(num); i++) {
        if (num % i === 0) return false;
    }
    return true;
}

class Block {
    constructor(id, number, time, previousHash = "0") {
        this.id = id;
        this.number = number;
        this.time = time;
        this.previousHash = previousHash;
        this.hash = this.calculateHash();
    }

    calculateHash() {
        return crypto.createHash('sha256')
            .update(this.id + this.number + this.time + this.previousHash)
            .digest('hex');
    }
}

class Blockchain {
    constructor() {
        this.chain = [this.createGenesisBlock()];
    }

    createGenesisBlock() {
        return new Block(1, 0, Date.now(), "0");
    }

    getLatestBlock() {
        return this.chain[this.chain.length - 1];
    }

    addBlockIfPrime(number) {
        if (isPrime(number)) {
            let newBlock = new Block(this.chain.length + 1, number, Date.now());
            newBlock.previousHash = this.getLatestBlock().hash;
            newBlock.hash = newBlock.calculateHash();
            this.chain.push(newBlock);
            console.log(`[Success] ${number} is a Prime Number. Block Added!`);
        } else {
            console.log(`[Rejected] ${number} is NOT a Prime Number. Block not added.`);
        }
    }
}

module.exports = { Blockchain };
