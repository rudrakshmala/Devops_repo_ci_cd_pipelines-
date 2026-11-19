import hashlib
import time
import json


class LedgerBlock:
    def __init__(self, idx, tx_data, prev_hash):
        self.idx = idx
        self.tx_data = tx_data
        self.prev_hash = prev_hash
        self.timestamp = time.time()
        self.hash = self.calc_hash()

    def calc_hash(self):
        record = json.dumps({
            "idx": self.idx,
            "tx": self.tx_data,
            "prev": self.prev_hash,
            "ts": self.timestamp
        }, sort_keys=True).encode()
        return hashlib.sha256(record).hexdigest()


class BankChain:
    def __init__(self):
        self.blocks = [LedgerBlock(0, "Genesis", "0")]
        self.accounts = {}

    def add_tx(self, tx):
        prev = self.blocks[-1].hash
        new_b = LedgerBlock(len(self.blocks), tx, prev)
        self.blocks.append(new_b)
        print(f"Transaction secured in Block {new_b.idx}.")

    def open_account(self, user):
        if user not in self.accounts:
            self.accounts[user] = 0
            self.add_tx({"action": "OPEN_ACCT", "user": user})
            print(f"Account opened for {user}.")
        else:
            print("Account already exists.")

    def deposit_funds(self, user, amt):
        if user in self.accounts and amt > 0:
            self.accounts[user] += amt
            self.add_tx({"action": "DEPOSIT", "user": user, "amt": amt})
            print(f"Deposited {amt}. Balance: {self.accounts[user]}")
        else:
            print("Invalid account or amount.")

    def withdraw_funds(self, user, amt):
        if user in self.accounts and 0 < amt <= self.accounts[user]:
            self.accounts[user] -= amt
            self.add_tx({"action": "WITHDRAW", "user": user, "amt": amt})
            print(f"Withdrew {amt}. Balance: {self.accounts[user]}")
        else:
            print("Invalid account or insufficient funds.")


if __name__ == "__main__":
    bank = BankChain()
    while True:
        print("\n1. Open Account | 2. Deposit | 3. Withdraw | 4. Exit")
        choice = input("Select an option: ")
        if choice == '1':
            bank.open_account(input("Enter username: "))
        elif choice == '2':
            bank.deposit_funds(input("Enter username: "), float(input("Amount: ")))
        elif choice == '3':
            bank.withdraw_funds(input("Enter username: "), float(input("Amount: ")))
        elif choice == '4':
            break
