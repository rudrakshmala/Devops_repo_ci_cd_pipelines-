const crypto = require('crypto');

class Block {
    constructor(id, num1, num2, time, previousHash = "0") {
        this.id = id;
        this.num1 = num1;
        this.num2 = num2;
        this.sum = num1 + num2;
        this.time = time;
        this.previousHash = previousHash;
        this.hash = this.calculateHash();
    }

    calculateHash() {
        return crypto.createHash('sha256')
            .update(this.id + this.num1 + this.num2 + this.sum + this.time + this.previousHash)
            .digest('hex');
    }
}

class Blockchain {
    constructor() {
        this.chain = [this.createGenesisBlock()];
    }

    createGenesisBlock() {
        return new Block(1, 0, 0, Date.now(), "0");
    }

    getLatestBlock() {
        return this.chain[this.chain.length - 1];
    }

    addBlock(block) {
        block.previousHash = this.getLatestBlock().hash;
        block.hash = block.calculateHash();
        this.chain.push(block);
    }
}

module.exports = { Block, Blockchain };
