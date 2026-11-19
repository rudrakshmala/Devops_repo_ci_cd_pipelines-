const crypto = require('crypto');

// Mathematically robust Happy Number checker
function checkHappy(n) {
    let seen = new Set();
    while (n !== 1 && !seen.has(n)) {
        seen.add(n);
        let sum = 0;
        while (n > 0) {
            let r = n % 10;
            sum += (r * r);
            n = Math.floor(n / 10);
        }
        n = sum;
    }
    return n === 1 ? "Happy No." : "Not Happy";
}

class Block {
    constructor(id, number, result, time, previousHash = "0") {
        this.id = id;
        this.number = number;
        this.result = result;
        this.time = time;
        this.previousHash = previousHash;
        this.hash = this.calculateHash();
    }

    calculateHash() {
        return crypto.createHash('sha256')
            .update(this.id + this.number + this.result + this.time + this.previousHash)
            .digest('hex');
    }
}

class Blockchain {
    constructor() {
        this.chain = [this.createGenesisBlock()];
    }

    createGenesisBlock() {
        return new Block(1, 0, "Genesis Block", Date.now(), "0");
    }

    getLatestBlock() {
        return this.chain[this.chain.length - 1];
    }

    addBlockIfHappy(number) {
        let result = checkHappy(number);
        if (result === "Happy No.") {
            let newBlock = new Block(this.chain.length + 1, number, result, Date.now());
            newBlock.previousHash = this.getLatestBlock().hash;
            newBlock.hash = newBlock.calculateHash();
            this.chain.push(newBlock);
            console.log(`[Added] ${number} is a Happy Number!`);
        } else {
            console.log(`[Rejected] ${number} is ${result}.`);
        }
    }
}

module.exports = { Blockchain };
