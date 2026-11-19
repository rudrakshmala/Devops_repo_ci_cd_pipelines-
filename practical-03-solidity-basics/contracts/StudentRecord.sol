// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StudentRecord {
    struct Student {
        uint id;
        string name;
        uint age;
        string course;
    }

    // State variable to store one student
    Student public student;

    // Function to set student details
    function setStudent(uint _id, string memory _name, uint _age, string memory _course) public {
        student = Student(_id, _name, _age, _course);
    }

    // Function to retrieve student details
    function getStudent() public view returns (uint, string memory, uint, string memory) {
        return (student.id, student.name, student.age, student.course);
    }
}
