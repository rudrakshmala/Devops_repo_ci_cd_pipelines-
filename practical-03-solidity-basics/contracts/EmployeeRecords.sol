// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EmployeeRecords {
    struct Employee {
        uint id;
        string name;
        string department;
        uint salary;
    }

    // Mapping from employee ID to Employee struct
    mapping(uint => Employee) public employees;

    function addEmployee(uint _id, string memory _name, string memory _dept, uint _salary) public {
        require(employees[_id].id == 0, "Employee ID already exists");
        employees[_id] = Employee(_id, _name, _dept, _salary);
    }

    function updateEmployee(uint _id, string memory _name, string memory _dept, uint _salary) public {
        require(employees[_id].id != 0, "Employee does not exist");
        employees[_id] = Employee(_id, _name, _dept, _salary);
    }

    function getEmployee(uint _id) public view returns (uint, string memory, string memory, uint) {
        require(employees[_id].id != 0, "Employee does not exist");
        Employee memory e = employees[_id];
        return (e.id, e.name, e.department, e.salary);
    }
}
