# Practical 11 — Vehicle Rental & Crowdfunding (Remix IDE)

| Q | Contracts | File | Concept |
|---|-----------|------|---------|
| 1 | `Rental` → `CarRental`, `BikeRental`; `RentalManager` | `contracts/VehicleRental.sol` | `virtual` / `override`, events, enum selection |
| 2 | `CampaignDetails` → `Crowdfunding` | `contracts/Crowdfunding.sol` | Parent/child, events, deadline, refunds |

## One-time setup (Remix IDE)

1. Open **<https://remix.ethereum.org/>** in your browser (no install, no account, no `npm`).
2. In the **File Explorer** (left sidebar), create a new file for each `.sol` file in this practical's `contracts/` folder — or use *Upload files* / drag-and-drop the files in.
3. Open the **Solidity Compiler** tab, choose compiler version **0.8.24** (any `0.8.24`+ works), and click **Compile**. A green tick means success.
4. Open the **Deploy & Run Transactions** tab. Keep **ENVIRONMENT = Remix VM (Prague/Cancun/...)** — it is a fake in-browser blockchain with 15 pre-funded accounts (100 ETH each), so nothing costs real money.

## Q1 — Vehicle rental (function overriding)
1. Compile `VehicleRental.sol`.
2. In **Deploy**, choose **RentalManager**, enter `"Super Rentals"` as `_agencyName`, click **transact**. (It auto-deploys a `CarRental` and a `BikeRental`.)
3. Expand the deployed **RentalManager**.
4. **Car:** in **rentVehicle** enter `_type` = `0`, `_days` = `5` → **transact**. Click **currentCalculatedRent** → `2500` (5 × 500).
5. **Bike:** `_type` = `1`, `_days` = `5` → **transact**. **currentCalculatedRent** → `750` (5 × 150).
6. Open the transaction in the Remix console → *logs* shows the **VehicleRented** event (renter, days, cost, vehicle type).
7. Optional: click **carContract** / **bikeContract** to see the child contract addresses.

## Q2 — Crowdfunding
1. Compile `Crowdfunding.sol`.
2. In **Deploy**, choose **Crowdfunding**. Enter the goal `1000000000000000000` (1 ETH in Wei) and duration `1` (day). **transact**.
3. Switch **ACCOUNT** to a different account (so you are not the owner). Set **VALUE** = `1` Ether and click the red **contribute** button.
4. In the console, open the transaction → *logs*: **ContributionReceived** and **GoalReached** events are emitted.
5. Check **totalFunds** (`1000000000000000000`) and **contributions** (paste your address).
6. Switch back to the **first** account (the owner), set **VALUE** to `0`, click **withdrawFunds** → the owner receives the ETH.

### Testing refunds — read this
The original practical suggests deploying with a duration of `0` to test `refund`. That does **not** work: with duration 0 the deadline equals the deploy time, so `contribute()` immediately reverts with *"Campaign deadline has passed"* and nobody can contribute.

What you can do instead:
- Deploy with goal `10000000000000000000` (10 ETH) and duration `1`, contribute `1` ETH, then click **refund** → reverts with *"Campaign is still active"*. This shows the deadline guard works.
- To see a real refund you must wait until after the deadline (1 day) with the goal unmet, then call **refund** from the contributor account. Remix VM cannot fast-forward time; a Hardhat test (`time.increase`) can.
