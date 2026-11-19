# Practical 6 — Quiz System & Inheritance (Remix IDE)

| Q | Contract(s) | File | Concept |
|---|-------------|------|---------|
| 1 | `Quiz` | `contracts/Quiz.sol` | Create questions, answer them, per-user correct/incorrect counters |
| 2 | `Animal` → `Dog` | `contracts/SingleInheritance.sol` | Single inheritance, `virtual` / `override` |
| 3 | `Flyer`, `Swimmer` → `Duck` | `contracts/MultipleInheritance.sol` | Multiple inheritance |

## One-time setup (Remix IDE)

1. Open **<https://remix.ethereum.org/>** in your browser (no install, no account, no `npm`).
2. In the **File Explorer** (left sidebar), create a new file for each `.sol` file in this practical's `contracts/` folder — or use *Upload files* / drag-and-drop the files in.
3. Open the **Solidity Compiler** tab, choose compiler version **0.8.24** (any `0.8.24`+ works), and click **Compile**. A green tick means success.
4. Open the **Deploy & Run Transactions** tab. Keep **ENVIRONMENT = Remix VM (Prague/Cancun/...)** — it is a fake in-browser blockchain with 15 pre-funded accounts (100 ETH each), so nothing costs real money.

## Q1 — Quiz
1. Compile `Quiz.sol`; deploy **Quiz**.
2. **addQuestion**: `"What is 2+2?"`, `"4"` → **transact**.
3. **answerQuestion** (correct): `0`, `"4"` → **transact**.
4. **answerQuestion** (wrong): `0`, `"5"` → **transact**.
5. Copy your account address from the **ACCOUNT** box. Paste it into **correctAnswers** and **incorrectAnswers** and click each blue button → `1` and `1`.
6. **getTotalQuestions** → `1`.

## Q2 — Single inheritance
1. Compile `SingleInheritance.sol`.
2. In **Deploy**, choose **Dog** (not *Animal*) → **Deploy**.
3. Click **species** → `"Canine"` (set by the parent constructor).
4. Click **eat** → `"I am eating dog food!"` (overridden function).
5. Click **bark** → `"Woof! Woof!"` (child's own function).

## Q3 — Multiple inheritance
1. Compile `MultipleInheritance.sol`.
2. In **Deploy**, choose **Duck** → **Deploy**.
3. **fly** → `"I am flying in the sky!"` (from Flyer)
4. **swim** → `"I am swimming in the water!"` (from Swimmer)
5. **quack** → `"Quack! Quack!"` (Duck's own)

> If the **CONTRACT** dropdown lists several contracts from one file, always pick the one named in the steps.
