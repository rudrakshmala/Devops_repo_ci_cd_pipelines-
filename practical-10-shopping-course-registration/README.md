# Practical 10 — Online Shopping & Course Registration (Remix IDE)

| Q | Contracts | File | Concept |
|---|-----------|------|---------|
| 1 | `Product` → `OnlineStore` | `contracts/OnlineStore.sol` | Constructor chaining, `payable` purchase, stock tracking, refund of excess ETH |
| 2 | `Person` → `Student` | `contracts/CourseRegistration.sol` | Constructor chaining, seat limit, duplicate-registration check |

## One-time setup (Remix IDE)

1. Open **<https://remix.ethereum.org/>** in your browser (no install, no account, no `npm`).
2. In the **File Explorer** (left sidebar), create a new file for each `.sol` file in this practical's `contracts/` folder — or use *Upload files* / drag-and-drop the files in.
3. Open the **Solidity Compiler** tab, choose compiler version **0.8.24** (any `0.8.24`+ works), and click **Compile**. A green tick means success.
4. Open the **Deploy & Run Transactions** tab. Keep **ENVIRONMENT = Remix VM (Prague/Cancun/...)** — it is a fake in-browser blockchain with 15 pre-funded accounts (100 ETH each), so nothing costs real money.

## Q1 — Online store
1. Compile `OnlineStore.sol`.
2. In **Deploy**, choose **OnlineStore**. Click the ▼ arrow next to *Deploy* and enter:
   - `_prodId`: `1`
   - `_name`: `"Laptop"`
   - `_price`: `1000000000000000000` (1 ETH in Wei)
   - `_stock`: `10`

   Click **transact**.
3. Set **VALUE** = `1`, unit **Ether**.
4. In the deployed contract, enter `1` in **purchaseProduct** and click the red button — succeeds.
5. Click blue **stock** → `9`.
6. Failure cases: quantity `0` → *"Quantity must be greater than zero"*; sending less ETH than `price × quantity` → *"Insufficient Ether sent"*; quantity above stock → *"Not enough stock available"*. Sending extra ETH is refunded automatically.

## Q2 — Course registration
1. Compile `CourseRegistration.sol`.
2. In **Deploy**, choose **Student** and enter:
   - `_studName`: `"Alice"`
   - `_studId`: `101`
   - `_courseName`: `"Blockchain 101"`
   - `_courseFees`: `1000000000000000000` (1 ETH)
   - `_maxSeats`: `2`

   Click **transact**.
3. Set **VALUE** = `1` Ether. With the first account selected, click **registerForCourse** — succeeds.
4. Click **registerForCourse** again with the *same* account → *"Student is already registered for this course"*.
5. Switch **ACCOUNT** to the second account, click **registerForCourse** → succeeds (seats 2/2). Check **currentlyEnrolled** → `2`.
6. Switch to a third account, click **registerForCourse** → *"Registration closed: Maximum seats reached"*.

> Reverted transactions show a red error in the Remix console at the bottom — that is the expected outcome for the failure tests.
