# Practical 3 — Solidity Basics (Remix IDE)

Five beginner smart contracts. **Nothing to install** — everything runs in the browser.

| Q | Contract | File | Concept |
|---|----------|------|---------|
| 1 | `HelloWorld` | `contracts/HelloWorld.sol` | String state variable + setter |
| 2 | `Calculator` | `contracts/Calculator.sol` | add / subtract / multiply / divide, `require` checks |
| 3 | `StudentRecord` | `contracts/StudentRecord.sol` | `struct` |
| 4 | `EmployeeRecords` | `contracts/EmployeeRecords.sol` | `struct` + `mapping` (add / get / update) |
| 5 | `PalindromeChecker` | `contracts/PalindromeChecker.sol` | Loop and arithmetic |

## One-time setup (Remix IDE)

1. Open **<https://remix.ethereum.org/>** in your browser (no install, no account, no `npm`).
2. In the **File Explorer** (left sidebar), create a new file for each `.sol` file in this practical's `contracts/` folder — or use *Upload files* / drag-and-drop the files in.
3. Open the **Solidity Compiler** tab, choose compiler version **0.8.24** (any `0.8.24`+ works), and click **Compile**. A green tick means success.
4. Open the **Deploy & Run Transactions** tab. Keep **ENVIRONMENT = Remix VM (Prague/Cancun/...)** — it is a fake in-browser blockchain with 15 pre-funded accounts (100 ETH each), so nothing costs real money.

> Do steps 3–4 again for each contract. Each Q below is independent.

## Q1 — Hello World
1. Compile `HelloWorld.sol`; in **Deploy**, choose contract **HelloWorld** → click **Deploy**.
2. Under *Deployed Contracts*, expand it and click the blue **message** button → shows `"Hello World"`.
3. Type `Hello Solidity` (with quotes) into **setMessage**, click the orange button, then click **message** again → shows the new text.

## Q2 — Arithmetic operations
1. Compile `Calculator.sol` and deploy **Calculator**.
2. Expand the contract. Click the ▼ arrow beside each function, enter `a` = `10`, `b` = `5`, click **call**.
3. Expected: add → `15`, subtract → `5`, multiply → `50`, divide → `2`.
4. Error checks: `subtract(5, 10)` reverts with *"Subtraction would result in a negative number"*; `divide(10, 0)` reverts with *"Cannot divide by zero"*.

## Q3 — Store & display student details
1. Compile `StudentRecord.sol` and deploy **StudentRecord**.
2. In **setStudent** enter: `1`, `"Alice"`, `20`, `"Computer Science"` → click **transact**.
3. Click **getStudent** (or **student**) → shows the details just stored.

## Q4 — Employee details (struct + mapping)
1. Compile `EmployeeRecords.sol` and deploy **EmployeeRecords**.
2. **addEmployee**: `101`, `"Bob"`, `"HR"`, `50000` → **transact**.
3. **getEmployee**: `101` → **call** → shows Bob / HR / 50000.
4. **updateEmployee**: `101`, `"Bob"`, `"Finance"`, `60000` → **transact**; then **getEmployee** `101` again → department is now Finance, salary 60000.
5. Adding id `101` a second time reverts with *"Employee ID already exists"*.

## Q5 — Palindrome checker
1. Compile `PalindromeChecker.sol` and deploy **PalindromeChecker**.
2. **isPalindrome**: `12321` (or `1221`) → **call** → `true`.
3. **isPalindrome**: `12345` → `false`.

## Troubleshooting
| Problem | Fix |
|---|---|
| Compile error about pragma | Select compiler 0.8.24 or newer in the Compiler tab |
| Strings rejected | Wrap text inputs in double quotes: `"Alice"` |
| Old contracts clutter the panel | Click the trash-can icon in *Deployed Contracts* |
