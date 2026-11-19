# Practical 5 — BankC & StudentGrade (Remix IDE)

| Q | Contract | File | Concept |
|---|----------|------|---------|
| 1 | `BankC` | `contracts/BankC.sol` | `payable` deposit, sending ETH from the contract to another address |
| 2 | `StudentGrade` | `contracts/StudentGrade.sol` | struct + mapping + array, duplicate check, grade from average marks |

## One-time setup (Remix IDE)

1. Open **<https://remix.ethereum.org/>** in your browser (no install, no account, no `npm`).
2. In the **File Explorer** (left sidebar), create a new file for each `.sol` file in this practical's `contracts/` folder — or use *Upload files* / drag-and-drop the files in.
3. Open the **Solidity Compiler** tab, choose compiler version **0.8.24** (any `0.8.24`+ works), and click **Compile**. A green tick means success.
4. Open the **Deploy & Run Transactions** tab. Keep **ENVIRONMENT = Remix VM (Prague/Cancun/...)** — it is a fake in-browser blockchain with 15 pre-funded accounts (100 ETH each), so nothing costs real money.

## Q1 — BankC (Ether transactions)
1. Compile `BankC.sol`; deploy **BankC**.
2. **Deposit:** in the **VALUE** box enter `5`, unit **Ether**. Expand the deployed contract and click the red **deposit** button.
3. Click **getContractBalance** → `5000000000000000000` (5 ETH in Wei).
4. **Transfer:** open the **ACCOUNT** dropdown and copy the address of *another* account (e.g. Account #2). Set **VALUE** back to `0`.
5. In **transferE**: paste that address into `_recipient`, enter `1000000000000000000` (1 ETH) for `_amount` → **transact**.
6. The recipient's balance rises by 1 ETH; **getContractBalance** now shows `4000000000000000000`.
7. Try an amount larger than the contract balance → *"Insufficient contract balance"*.

> Note: `transferE` is `public` with no owner check (as in the original practical), so any account can call it. Fine for a lab, not for real use.

## Q2 — StudentGrade
1. Compile `StudentGrade.sol`; deploy **StudentGrade**.
2. **addStudent** — enter:
   - `_id`: `101`
   - `_name`: `"Alice"`
   - `_homeAddress`: `"123 Main St"`
   - `_age`: `20`
   - `_marks`: `[85,90,95]` (use square brackets for arrays)

   Click **transact**.
3. Repeat **addStudent** with id `101` → fails with *"Student ID already exists"* (duplicate check).
4. **totalStudent** → `1`.
5. **getAllStudents** → nested tuple with Alice's data.
6. **displayDetail** `101` → id, name, address, age, marks.
7. **getGrade** `101` → average = (85+90+95)/3 = 90 → returns `"A"`.

Grade scale: ≥90 A · ≥80 B · ≥70 C · ≥60 D · otherwise F.
