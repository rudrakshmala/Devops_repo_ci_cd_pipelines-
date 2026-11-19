# Practical 4 — User Banking System (Remix IDE)

One contract, `UserBanking`, that lets each wallet address **create an account**, **deposit ETH**, **withdraw ETH** and **check its balance**, using a `struct User { accountNo, username, balance, isCreated }` stored in a `mapping(address => User)`.

File: `contracts/UserBanking.sol`

## One-time setup (Remix IDE)

1. Open **<https://remix.ethereum.org/>** in your browser (no install, no account, no `npm`).
2. In the **File Explorer** (left sidebar), create a new file for each `.sol` file in this practical's `contracts/` folder — or use *Upload files* / drag-and-drop the files in.
3. Open the **Solidity Compiler** tab, choose compiler version **0.8.24** (any `0.8.24`+ works), and click **Compile**. A green tick means success.
4. Open the **Deploy & Run Transactions** tab. Keep **ENVIRONMENT = Remix VM (Prague/Cancun/...)** — it is a fake in-browser blockchain with 15 pre-funded accounts (100 ETH each), so nothing costs real money.

## Run the practical

1. Compile `UserBanking.sol` (compiler 0.8.24).
2. In **Deploy**, choose contract **UserBanking** → click **Deploy**.
3. **Create account** — expand the deployed contract, expand **createAccount**, enter `1001` and `"JohnDoe"`, click **transact**.
4. **Deposit** — scroll up to the **VALUE** box (below *Gas limit*), type `5`, change the unit from *Wei* to **Ether**. Scroll down and click the red **depositAmount** button.
5. **Get balance** — click the blue **getBalance** → returns `5000000000000000000` (5 ETH in Wei).
6. **Withdraw** — set **VALUE** back to `0`, then in **withdrawAmount** enter `2000000000000000000` (2 ETH in Wei) and click **transact**.
7. Click **getBalance** again → `3000000000000000000`. Your account's ETH at the top increases by about 2 ETH (minus tiny gas).

## Things to try (error cases)
- Call **createAccount** a second time from the same account → *"Account already exists for this address"*.
- Switch to a different account in the **ACCOUNT** dropdown and call **getBalance** → *"Account does not exist."* (balances are per-address).
- Withdraw more than your balance → *"Insufficient balance in account"*.

## Notes
- Amounts are in **Wei** (1 ETH = 10^18 Wei).
- **getBalance** uses `msg.sender`, so it returns the balance of whichever account is selected.
