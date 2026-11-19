// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract BankC {
    // 1. Deposit function (payable) to receive Ether into the contract
    function deposit() public payable {
        // msg.value automatically holds the amount of Ether (in Wei) sent
        // No extra logic is strictly needed; the contract's balance increases.
    }

    // 2. Transfer function to send Ether from the contract to another address
    function transferE(address payable _recipient, uint _amount) public {
        // Check if the contract has sufficient balance
        require(address(this).balance >= _amount, "Insufficient contract balance");

        // Transfer the specified amount to the recipient
        _recipient.transfer(_amount);
    }

    // Helper function to easily view the current balance of the contract
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
