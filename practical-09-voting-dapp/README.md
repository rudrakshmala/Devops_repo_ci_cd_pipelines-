# Practical 09 — Voting DApp

An election DApp with two candidates (**Modi** and **Gandhi**). Each wallet address can vote **once**; the contract keeps the tally and can reveal the winner. Voting is a real transaction, so MetaMask asks you to confirm it.

| Layer | Tool |
|-------|------|
| Smart contract | Solidity (`contracts/Voting.sol`) |
| Local blockchain, compile & deploy | Hardhat 3 + Ignition |
| Frontend | Plain HTML/JS served by Vite, talks to the chain with `ethers` v6 |
| Wallet | MetaMask browser extension |

## Project layout

```
practical-09-voting-dapp/
├── contracts/Voting.sol        # the smart contract
├── ignition/modules/Voting.ts    # deployment instructions
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
cd practical-09-voting-dapp
npm install
```

This installs Hardhat, the Viem toolbox, Vite and ethers from `package.json`.

<details>
<summary><b>Fallback: build the project from scratch (exactly as in the lab sheet)</b></summary>

Use this if `npm install` complains about version conflicts.

```bash
mkdir voting-dapp
cd voting-dapp
npm init -y
npm install --save-dev hardhat
npx hardhat init
```

When asked, choose **TypeScript minimal project** (Hardhat 3 / Viem) and accept the defaults. Then:

```bash
npm install ethers
npm install --save-dev vite
```

Now copy the files from this folder over the generated ones: `contracts/Voting.sol`, `hardhat.config.ts`, `ignition/modules/Voting.ts`, and the whole `frontend/` folder. Delete the sample contract/module/test files that `hardhat init` created (e.g. `Counter.sol`, `Counter.ts`) so they do not clash.
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
npx hardhat ignition deploy ./ignition/modules/Voting.ts --network localhost
```

(or `npm run deploy`). If asked to confirm, type `y`.

The output ends with the deployed address, like:

```
VotingModule#Voting - 0x5FbDB2315678afecb367f032d93F642f64180aa3
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

1. Click **Connect Wallet** → approve in MetaMask. The current vote counts load automatically.
2. Click **Vote for Modi** (or **Vote for Gandhi**) → **confirm** the transaction in the MetaMask popup. Status goes: *Please confirm…* → *Waiting…* → *Successfully voted ✅*, and the counters update.
3. Click **Reveal Winner** → shows `Modi`, `Gandhi` or `Tie`.
4. Click a vote button again with the **same account** → fails with *"Failed! (Did you already vote?) ❌"* — the contract allows one vote per address.

### Voting from another account (to test "one vote per account")

1. In **Terminal 1** (where `npx hardhat node` is running) scroll to the list of accounts and private keys.
2. Import **Account #0**'s private key into MetaMask (*Add account or hardware wallet → Import account*) and vote with it.
3. Import **Account #1**'s private key the same way.
4. Switch MetaMask to the new account, **refresh** the page, click **Connect Wallet** (it should show the new address) and vote again — this time the contract accepts it.
5. Repeat with Account #2, #3, … to build up the tally, then click **Reveal Winner**.

> Votes live on the local chain. Restarting `hardhat node` wipes them — redeploy afterwards.

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
