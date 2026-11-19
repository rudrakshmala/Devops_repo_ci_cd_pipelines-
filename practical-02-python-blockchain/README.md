# Practical 2 — Blockchain in Python

| Q | Topic | File |
|---|-------|------|
| 1 | Blockchain that records **Armstrong numbers** and validates the chain | `armstrong_chain.py` |
| 2 | A block that checks whether two statements are **anagrams** | `anagram_block.py` |
| 3 | **Interactive banking** ledger (open account, deposit, withdraw) | `banking_ledger.py` |

## Prerequisites

- **Python 3.8+** — check with `python --version` (or `python3 --version` on Linux/macOS).
- **No `pip install` needed.** Only the built-in `hashlib`, `json` and `time` modules are used.

> On Linux/macOS use `python3` instead of `python` in the commands below.

## Step-by-step

1. Open a terminal in this folder:
   ```bash
   cd practical-02-python-blockchain
   ```
2. **Q1 – Armstrong chain**
   ```bash
   python armstrong_chain.py
   ```
   Expected:
   ```
   Block 1 added! Number 153 Armstrong status: True
   Block 2 added! Number 22 Armstrong status: False
   Is the blockchain valid? True
   ```
   (153 = 1³ + 5³ + 3³, so it is an Armstrong number; 22 is not.)
3. **Q2 – Anagram block**
   ```bash
   python anagram_block.py
   ```
   Type two statements when asked, e.g. `Listen` and `Silent`. Expected:
   ```
   Are Anagrams: True
   Cryptographic Hash: <64-character SHA-256 hash>
   ```
   Try `Hello` / `World` to see `False`. Spaces and upper/lower case are ignored.
4. **Q3 – Banking blockchain**
   ```bash
   python banking_ledger.py
   ```
   A menu appears. Suggested walkthrough:
   1. Type `1` → username `raj` → *Account opened*
   2. Type `2` → `raj` → amount `500` → *Balance: 500.0*
   3. Type `3` → `raj` → amount `200` → *Balance: 300.0*
   4. Type `3` → `raj` → amount `999` → *Invalid account or insufficient funds.*
   5. Type `4` to exit.

   Every successful action is stored as a new block ("Transaction secured in Block N").

## How it works

Each block stores its data, the previous block's hash, a timestamp, and its own SHA-256 hash. `validate_chain()` (Q1) recomputes every hash and checks each block points to the right predecessor — if any block were edited, it would return `False`.

## Troubleshooting

| Problem | Fix |
|---|---|
| `python: command not found` | Use `python3`, or install Python from <https://python.org> |
| `ValueError` in Q3 | The amount must be a number (e.g. `250`) |
