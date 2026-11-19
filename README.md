# Blockchain Practicals

A collection of blockchain lab practicals — blockchain in Node.js and Python, Solidity smart contracts (Remix IDE), and full-stack DApps (Hardhat + ethers + Vite + MetaMask).

Every practical lives in its own folder with its **own `README.md`** containing prerequisites, dependency installation and step-by-step instructions.

## Practicals

| # | Folder | Topic | How it runs | Install needed? |
|---|--------|-------|-------------|-----------------|
| 1 | [`practical-01-nodejs-blockchain`](practical-01-nodejs-blockchain) | Blockchain in Node.js: add two numbers, prime numbers, happy numbers | `node` in terminal | Node.js only (no packages) |
| 2 | [`practical-02-python-blockchain`](practical-02-python-blockchain) | Blockchain in Python: Armstrong numbers, anagram block, banking ledger | `python` in terminal | Python 3 only (no packages) |
| 3 | [`practical-03-solidity-basics`](practical-03-solidity-basics) | Hello World, Calculator, Student struct, Employee struct+mapping, Palindrome | Remix IDE | None (browser) |
| 4 | [`practical-04-user-banking`](practical-04-user-banking) | User banking system (create account, deposit, withdraw, balance) | Remix IDE | None (browser) |
| 5 | [`practical-05-bank-student-grades`](practical-05-bank-student-grades) | `BankC` Ether transfers; `StudentGrade` with grades | Remix IDE | None (browser) |
| 6 | [`practical-06-quiz-inheritance`](practical-06-quiz-inheritance) | Quiz contract; single & multiple inheritance | Remix IDE | None (browser) |
| 7 | — | *Not included in the source zip (see note below)* | — | — |
| 8 | [`practical-08-prime-checker-dapp`](practical-08-prime-checker-dapp) | Prime Number Checker DApp | Hardhat + Vite + MetaMask | `npm install` |
| 9 | [`practical-09-voting-dapp`](practical-09-voting-dapp) | Voting DApp (one vote per account) | Hardhat + Vite + MetaMask | `npm install` |
| 10 | [`practical-10-shopping-course-registration`](practical-10-shopping-course-registration) | Online shopping (payable) & course registration | Remix IDE | None (browser) |
| 11 | [`practical-11-rental-crowdfunding`](practical-11-rental-crowdfunding) | Vehicle rental (overriding) & crowdfunding (events, refunds) | Remix IDE | None (browser) |
| 12 | [`practical-12-addition-dapp`](practical-12-addition-dapp) | Basic Addition DApp | Hardhat + Vite + MetaMask | `npm install` |
| 13 | [`practical-13-perfect-number-dapp`](practical-13-perfect-number-dapp) | Perfect Number DApp | Hardhat + Vite + MetaMask | `npm install` |

> **Practical 7:** the source archive contained Practicals 1–6 and 8–13 only. If you have a Practical 7 document, add it as `practical-07-<name>/` and a row in the table above.

## Prerequisites by type

| Practicals | You need |
|------------|----------|
| 1 | [Node.js](https://nodejs.org) 16+ |
| 2 | [Python](https://python.org) 3.8+ |
| 3, 4, 5, 6, 10, 11 | A web browser → <https://remix.ethereum.org> |
| 8, 9, 12, 13 | [Node.js](https://nodejs.org) **22+**, [MetaMask](https://metamask.io/download) browser extension, two terminal windows |

## Getting started

```bash
git clone <your-repo-url>
cd blockchain-practicals
cd practical-01-nodejs-blockchain   # pick any practical, then follow its README.md
```

## Repository layout

```
blockchain-practicals/
├── README.md                              <- you are here
├── practical-01-nodejs-blockchain/        # JS files + README
├── practical-02-python-blockchain/        # Python files + README
├── practical-03-solidity-basics/          # contracts/*.sol + README (Remix)
├── practical-04-user-banking/
├── practical-05-bank-student-grades/
├── practical-06-quiz-inheritance/
├── practical-08-prime-checker-dapp/       # full Hardhat project + frontend
├── practical-09-voting-dapp/
├── practical-10-shopping-course-registration/
├── practical-11-rental-crowdfunding/
├── practical-12-addition-dapp/
└── practical-13-perfect-number-dapp/
```

Each DApp folder is a **self-contained** Node project (its own `package.json`), so run `npm install` inside the specific folder you are working on, not at the repo root.

## Publishing to GitHub

```bash
cd blockchain-practicals
git init
git add .
git commit -m "Add blockchain practicals"
git branch -M main
git remote add origin https://github.com/<your-username>/<repo-name>.git
git push -u origin main
```

`node_modules/`, build output and local deployment data are already excluded by `.gitignore`.

## Notes on changes from the original lab sheets

The code is the same as the lab sheets, apart from these small additions:
- DApps 12 and 13: `main.js` now shows a message if you click the button before connecting the wallet, and catches errors instead of failing silently.
- All DApp `index.html` files have `<meta charset="UTF-8">` added.
- Practical 11, Crowdfunding: the lab sheet's refund test (duration `0`) cannot work as written. The corrected testing advice is in that practical's README.
