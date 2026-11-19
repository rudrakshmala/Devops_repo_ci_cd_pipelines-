# Practical 08 — Prime Number Checker DApp

A DApp where the user types a number and a Solidity `isPrime` function (read via `ethers`) says whether it is prime. The function is `pure`, so checking costs **no gas** and needs **no MetaMask confirmation popup**.

| Layer | Tool |
|-------|------|
| Smart contract | Solidity (`contracts/PrimeChecker.sol`) |
| Local blockchain, compile & deploy | Hardhat 3 + Ignition |
| Frontend | Plain HTML/JS served by Vite, talks to the chain with `ethers` v6 |
| Wallet | MetaMask browser extension |

## Project layout

```
practical-08-prime-checker-dapp/
├── contracts/PrimeChecker.sol        # the smart contract
├── ignition/modules/PrimeChecker.ts    # deployment instructions
├── frontend/
│   ├── index.html                       # the page
│   └── main.js                          # wallet + contract calls (ethers)
├── hardhat.config.ts                    # compiler + networks
├── package.json  tsconfig.json
```

## 1. Prerequisites

| Need | Check | Notes |
|------|-------|-------|
| **Node.js 22 or newer** | `node -v` | Hardhat 3 requires it. Get it from <https://nodejs.org> (LTS). |
| **npm** | `npm -v` | Comes with Node. |
| **MetaMask** extension | — | <https://metamask.io/download> (Chrome / Brave / Edge / Firefox). Create a wallet if you have none. |
| **Two terminal windows** | — | One keeps the blockchain running, one is for everything else. |

## 2. Install dependencies

From the repository root:

```bash
cd practical-08-prime-checker-dapp
npm install
```

This installs Hardhat, the Viem toolbox, Vite and ethers from `package.json`.

<details>
<summary><b>Fallback: build the project from scratch (exactly as in the lab sheet)</b></summary>

Use this if `npm install` complains about version conflicts.

```bash
mkdir prime-checker-dapp
cd prime-checker-dapp
npm init -y
npm install --save-dev hardhat
npx hardhat init
```

When asked, choose **TypeScript minimal project** (Hardhat 3 / Viem) and accept the defaults. Then:

```bash
npm install ethers
npm install --save-dev vite
```

Now copy the files from this folder over the generated ones: `contracts/PrimeChecker.sol`, `hardhat.config.ts`, `ignition/modules/PrimeChecker.ts`, and the whole `frontend/` folder. Delete the sample contract/module/test files that `hardhat init` created (e.g. `Counter.sol`, `Counter.ts`) so they do not clash.
</details>

## 3. Compile the contract

```bash
npx hardhat compile
```

You should see *"Compiled 1 Solidity file"* (or similar) and no errors.

## 4. Start the local blockchain — Terminal 1

```bash
npx hardhat node
```

- It prints **20 test accounts**, each with 10,000 ETH and a private key.
- **Leave this terminal open.** Closing it stops the blockchain (and erases all state).

## 5. Deploy the contract — Terminal 2

Open a **second terminal** in the same project folder and run:

```bash
npx hardhat ignition deploy ./ignition/modules/PrimeChecker.ts --network localhost
```

(or `npm run deploy`). If asked to confirm, type `y`.

The output ends with the deployed address, like:

```
PrimeCheckerModule#PrimeChecker - 0x5FbDB2315678afecb367f032d93F642f64180aa3
```

**Check the address in `frontend/main.js`.** On a *fresh* node, the first deployment always gets `0x5FbDB2315678afecb367f032d93F642f64180aa3`, which is already in the file. If your address is different (e.g. you deployed twice or other contracts first), open `frontend/main.js` and replace the `contractAddress` value with yours.

## 6. Set up MetaMask

1. Open MetaMask → network dropdown → **Add a custom network** and enter:

   | Field | Value |
   |-------|-------|
   | Network name | `Hardhat Local` |
   | RPC URL | `http://127.0.0.1:8545` |
   | Chain ID | `31337` |
   | Currency symbol | `ETH` |

2. Switch MetaMask to **Hardhat Local**.
3. Import a test account: MetaMask → account menu → **Add account or hardware wallet → Import account** → paste a private key printed in Terminal 1 (use **Account #0**).

> ⚠️ These keys are public test keys that everyone knows. **Never send real ETH to them or reuse them on a real network.**

## 7. Run the frontend — Terminal 2

```bash
npx vite frontend --host 127.0.0.1
```

(or `npm run dev`). Open **<http://127.0.0.1:5173>** in the browser where MetaMask is installed.

## 8. Use the DApp

1. Click **Connect Wallet** → approve in MetaMask. Status changes to `Connected (0x…)`.
2. Type a number, e.g. `17`, and click **Check Prime** → green *"17 is a Prime Number! ✅"*.
3. Try `18` → red *"18 is NOT a Prime Number. ❌"*. Also try `1`, `2`, `97`, `100`.
4. No MetaMask popup appears for the check, because `isPrime` is a read-only (`pure`) call.

## Troubleshooting

| Symptom | Cause / fix |
|---------|-------------|
| `Unsupported Node.js version` / Hardhat won't start | Upgrade to Node 22+ |
| `npm install` version conflicts | Use the **fallback** in step 2 |
| Page says *Connect wallet first!* | Click **Connect Wallet** and approve the MetaMask popup |
| `window.ethereum` is undefined / nothing happens on Connect | MetaMask isn't installed or is disabled for this site |
| `could not decode result data (value="0x")` or *"Failed!"* | Wrong contract address, or you restarted `hardhat node` without redeploying. Redeploy (step 5) and update `contractAddress` |
| MetaMask shows *nonce too high* / transactions stuck after restarting the node | MetaMask → Settings → Advanced → **Clear activity tab data** |
| Wrong network | MetaMask must be on **Hardhat Local** (chain ID 31337) |
| Port 8545 or 5173 already in use | Close the old process, or pass `--port` to Vite |
| Redeploying | Stop the node (Ctrl+C), delete `ignition/deployments/`, restart `npx hardhat node`, deploy again |

## Stopping everything

Press **Ctrl + C** in both terminals.
