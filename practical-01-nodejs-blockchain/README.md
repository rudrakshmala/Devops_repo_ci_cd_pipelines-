# Practical 1 — Blockchain in Node.js

Three small blockchains written in plain JavaScript using Node's built-in `crypto` module (SHA-256).

| Q | Topic | Files |
|---|-------|-------|
| 1 | Blockchain that **adds two numbers** per block | `add_blockchain.js`, `test_add.js` |
| 2 | Blockchain that only accepts **prime numbers** | `prime_blockchain.js`, `test_prime.js` |
| 3 | Blockchain that only accepts **happy numbers** | `happy.js`, `test_happy.js` |

## Prerequisites

- **Node.js 16 or newer** — check with `node -v`. Download from <https://nodejs.org> if missing.
- **No `npm install` needed.** There are zero external dependencies.

## Step-by-step

1. Open a terminal and go into this folder:
   ```bash
   cd practical-01-nodejs-blockchain
   ```
2. **Q1 – Add two numbers**
   ```bash
   node test_add.js
   ```
   Expected: a JSON chain with 3 blocks (genesis + `10+15=25` + `50+50=100`). Each block's `previousHash` equals the `hash` of the block before it.
3. **Q2 – Prime numbers**
   ```bash
   node test_prime.js
   ```
   Expected output starts with:
   ```
   [Success] 7 is a Prime Number. Block Added!
   [Rejected] 10 is NOT a Prime Number. Block not added.
   [Success] 13 is a Prime Number. Block Added!
   ```
   followed by a chain with 3 blocks (genesis, 7, 13) — 10 was rejected.
4. **Q3 – Happy numbers**
   ```bash
   node test_happy.js
   ```
   Expected output starts with:
   ```
   [Added] 19 is a Happy Number!
   [Rejected] 4 is Not Happy.
   [Added] 7 is a Happy Number!
   ```

Shortcut: `npm run add`, `npm run prime`, `npm run happy` do the same thing.

## How it works

- **Block** – holds its data plus `previousHash` and its own `hash` (SHA-256 of all fields).
- **Blockchain** – an array of blocks that starts with a *genesis block*; each new block copies the previous block's hash, which links them together.
- **Prime check** – tries dividing by every number up to `√n`.
- **Happy check** – repeatedly replaces a number with the sum of the squares of its digits; it is happy if it reaches 1. A `Set` detects loops (unhappy numbers).

## Try your own numbers

Edit the test files, e.g. in `test_prime.js` add `primeChain.addBlockIfPrime(29);`, then re-run.

## Troubleshooting

| Problem | Fix |
|---|---|
| `node: command not found` | Install Node.js and reopen the terminal |
| `Cannot find module './add_blockchain'` | Run the command from inside this folder |
