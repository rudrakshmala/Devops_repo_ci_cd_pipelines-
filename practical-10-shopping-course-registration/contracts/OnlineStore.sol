// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 1. Base Contract
contract Product {
    uint public prodId;
    string public Prod_name;
    uint public price;
    uint public stock;

    // Initialize product details using the constructor
    constructor(uint _prodId, string memory _name, uint _price, uint _stock) {
        prodId = _prodId;
        Prod_name = _name;
        price = _price;
        stock = _stock;
    }
}

// 2. Derived Contract
contract OnlineStore is Product {
    event ProductPurchased(address indexed buyer, uint quantity, uint totalCost);

    // Pass arguments from the derived contract to the base constructor
    constructor(uint _prodId, string memory _name, uint _price, uint _stock)
        Product(_prodId, _name, _price, _stock) {}

    // Implement a purchase function that accepts Ether
    function purchaseProduct(uint quantity) public payable {
        require(quantity > 0, "Quantity must be greater than zero");
        require(stock >= quantity, "Not enough stock available");

        uint totalCost = price * quantity;
        require(msg.value >= totalCost, "Insufficient Ether sent");

        // Deduct stock
        stock -= quantity;

        // Refund any excess Ether sent by the buyer
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost);
        }

        emit ProductPurchased(msg.sender, quantity, totalCost);
    }
}
