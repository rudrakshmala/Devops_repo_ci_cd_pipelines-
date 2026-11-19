// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract HelloWorld {
    // String variable initialized with "Hello World"
    string public message = "Hello World";

    // Function to update the message
    function setMessage(string memory _newMessage) public {
        message = _newMessage;
    }
}
