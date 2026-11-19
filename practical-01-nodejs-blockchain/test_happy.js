const { Blockchain } = require('./happy');

let happyChain = new Blockchain();
happyChain.addBlockIfHappy(19); // 19 is a Happy Number (1^2 + 9^2 = 82 ... -> 1)
happyChain.addBlockIfHappy(4);  // 4 is Not Happy
happyChain.addBlockIfHappy(7);  // 7 is a Happy Number
console.log("\n--- Final Happy Blockchain ---");
console.log(JSON.stringify(happyChain, null, 4));
