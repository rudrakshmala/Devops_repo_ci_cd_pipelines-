// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UserBanking {
    // 1. Structure of a user
    struct User {
        uint accountNo;
        string username;
        uint balance;
        bool isCreated; // Internal flag to check if the user exists
    }

    // Mapping to associate a wallet address with a User struct
    mapping(address => User) public users;

    // 2. Function to create a new account
    function createAccount(uint _accountNo, string memory _username) public {
        // Ensure the caller doesn't already have an account
        require(!users[msg.sender].isCreated, "Account already exists for this address");

        // Initialize the user structure
        users[msg.sender] = User({
            accountNo: _accountNo,
            username: _username,
            balance: 0,
            isCreated: true
        });
    }

    // 3. Function to deposit amount (accepts Ether)
    function depositAmount() public payable {
        require(users[msg.sender].isCreated, "Account does not exist. Create an account first.");
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Update the user's balance in the struct
        users[msg.sender].balance += msg.value;
    }

    // 4. Function to withdraw amount
    function withdrawAmount(uint _amount) public {
        require(users[msg.sender].isCreated, "Account does not exist.");
        require(users[msg.sender].balance >= _amount, "Insufficient balance in account");

        // Deduct the amount from the user's balance
        users[msg.sender].balance -= _amount;

        // Transfer the Ether back to the user's wallet
        payable(msg.sender).transfer(_amount);
    }

    // 5. Function to get the current balance of the user
    function getBalance() public view returns (uint) {
        require(users[msg.sender].isCreated, "Account does not exist.");
        return users[msg.sender].balance;
    }
}
