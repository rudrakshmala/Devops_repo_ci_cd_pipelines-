// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// PARENT CONTRACT 1
contract Flyer {
    function fly() public pure returns (string memory) {
        return "I am flying in the sky!";
    }
}

// PARENT CONTRACT 2
contract Swimmer {
    function swim() public pure returns (string memory) {
        return "I am swimming in the water!";
    }
}

// CHILD CONTRACT (Multiple Inheritance from Flyer and Swimmer)
contract Duck is Flyer, Swimmer {
    // The Duck has access to both fly() and swim(), plus its own functions
    function quack() public pure returns (string memory) {
        return "Quack! Quack!";
    }
}
