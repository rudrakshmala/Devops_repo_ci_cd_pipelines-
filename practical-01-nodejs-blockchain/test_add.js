const { Block, Blockchain } = require('./add_blockchain');

let myCoin = new Blockchain();
console.log("Adding blocks...");
myCoin.addBlock(new Block(2, 10, 15, Date.now()));
myCoin.addBlock(new Block(3, 50, 50, Date.now()));
console.log(JSON.stringify(myCoin, null, 4));
