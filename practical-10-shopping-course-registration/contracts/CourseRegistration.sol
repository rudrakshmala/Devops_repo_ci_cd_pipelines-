// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 1. Base Contract
contract Person {
    string public Studname;
    uint public StudId;

    // Initialize person details using the constructor
    constructor(string memory _name, uint _id) {
        Studname = _name;
        StudId = _id;
    }
}

// 2. Derived Contract
contract Student is Person {
    string public coursename;
    uint public coursefees;
    uint public maxSeats;
    uint public currentlyEnrolled;

    // Tracks which wallet addresses are already registered
    mapping(address => bool) public isRegistered;

    event StudentRegistered(address studentAddress, string course);

    // Constructor initializes both base (Person) and derived (Student) variables
    constructor(
        string memory _studName,
        uint _studId,
        string memory _courseName,
        uint _courseFees,
        uint _maxSeats
    ) Person(_studName, _studId) {
        coursename = _courseName;
        coursefees = _courseFees;
        maxSeats = _maxSeats;
    }

    // Function to register a student for a course
    function registerForCourse() public payable {
        // Registration will be rejected if the student is already registered
        require(!isRegistered[msg.sender], "Student is already registered for this course");

        // Registration will be rejected if the seat is full
        require(currentlyEnrolled < maxSeats, "Registration closed: Maximum seats reached");

        // Ensure exact or excess fee is paid
        require(msg.value >= coursefees, "Insufficient course fees provided");

        isRegistered[msg.sender] = true;
        currentlyEnrolled++;

        // Refund excess payment
        if (msg.value > coursefees) {
            payable(msg.sender).transfer(msg.value - coursefees);
        }

        emit StudentRegistered(msg.sender, coursename);
    }
}
