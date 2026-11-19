// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StudentGrade {
    // 1. Structure to store student details
    struct Student {
        uint id;
        string name;
        string homeAddress;
        uint age;
        uint[] marks;
    }

    // 2. Mapping to associate student ID with details
    mapping(uint => Student) public stud_id;

    // Array to store IDs separately for looping
    uint[] public studentIds;

    // Variable to track total number of students
    uint public studentCount;

    // 3. Add a new student
    function addStudent(
        uint _id,
        string memory _name,
        string memory _homeAddress,
        uint _age,
        uint[] memory _marks
    ) public {
        // Prevent duplicate student IDs (assuming valid IDs are > 0)
        require(stud_id[_id].id == 0, "Student ID already exists");

        // Add to mapping
        stud_id[_id] = Student(_id, _name, _homeAddress, _age, _marks);

        // Add to array and increment count
        studentIds.push(_id);
        studentCount++;
    }

    // 4. Return total number of students
    function totalStudent() public view returns (uint) {
        return studentCount;
    }

    // 5. Retrieve details of all students
    function getAllStudents() public view returns (Student[] memory) {
        Student[] memory allStudents = new Student[](studentCount);
        for (uint i = 0; i < studentCount; i++) {
            allStudents[i] = stud_id[studentIds[i]];
        }
        return allStudents;
    }

    // 6. Return specific details of a particular student
    function displayDetail(uint _id) public view returns (
        uint id,
        string memory name,
        string memory homeAddress,
        uint age,
        uint[] memory marks
    ) {
        require(stud_id[_id].id != 0, "Student does not exist");
        Student memory s = stud_id[_id];
        return (s.id, s.name, s.homeAddress, s.age, s.marks);
    }

    // 7. Calculate average and return grade
    function getGrade(uint _id) public view returns (string memory) {
        require(stud_id[_id].id != 0, "Student does not exist");
        uint[] memory marks = stud_id[_id].marks;

        if (marks.length == 0) return "No Marks Available";

        uint totalMarks = 0;
        for (uint i = 0; i < marks.length; i++) {
            totalMarks += marks[i];
        }

        uint average = totalMarks / marks.length;

        if (average >= 90) return "A";
        else if (average >= 80) return "B";
        else if (average >= 70) return "C";
        else if (average >= 60) return "D";
        else return "F";
    }
}
