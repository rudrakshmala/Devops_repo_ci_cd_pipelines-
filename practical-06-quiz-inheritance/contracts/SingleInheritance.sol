// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// PARENT CONTRACT
contract Animal {
    string public species;

    constructor(string memory _species) {
        species = _species;
    }

    function eat() public pure virtual returns (string memory) {
        return "I am eating food.";
    }
}

// CHILD CONTRACT (Single Inheritance)
contract Dog is Animal {
    // Passes the species name up to the Parent constructor
    constructor() Animal("Canine") {}

    // Overriding the parent's function
    function eat() public pure override returns (string memory) {
        return "I am eating dog food!";
    }

    // Child's own unique function
    function bark() public pure returns (string memory) {
        return "Woof! Woof!";
    }
}
