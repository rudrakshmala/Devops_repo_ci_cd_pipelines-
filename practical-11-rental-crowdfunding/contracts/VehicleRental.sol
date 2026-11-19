// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 1. Parent Contract
contract Rental {
    string public agencyName;

    // Event emitted when a rental is recorded
    event VehicleRented(address indexed renter, uint daysRented, uint totalCost, string vehicleType);

    // Constructor to set the agency name
    constructor(string memory _agencyName) {
        agencyName = _agencyName;
    }

    // Virtual function to be overridden by child contracts
    // We pass the renter's address so the event logs the actual user, not the manager contract
    function calculateRent(uint daysRented, address renter) public virtual returns (uint) {
        return 0;
    }
}

// 2. Child Contract 1
contract CarRental is Rental {
    uint public carDailyRate = 500;

    constructor(string memory _agencyName) Rental(_agencyName) {}

    // Override the parent function
    function calculateRent(uint daysRented, address renter) public override returns (uint) {
        uint totalCost = daysRented * carDailyRate;
        emit VehicleRented(renter, daysRented, totalCost, "Car");
        return totalCost;
    }
}

// 3. Child Contract 2
contract BikeRental is Rental {
    uint public bikeDailyRate = 150;

    constructor(string memory _agencyName) Rental(_agencyName) {}

    // Override the parent function
    function calculateRent(uint daysRented, address renter) public override returns (uint) {
        uint totalCost = daysRented * bikeDailyRate;
        emit VehicleRented(renter, daysRented, totalCost, "Bike");
        return totalCost;
    }
}

// 4. Main Manager Contract for User Interaction
contract RentalManager {
    CarRental public carContract;
    BikeRental public bikeContract;

    // This variable will display the calculated rate to the user on Remix
    uint public currentCalculatedRent;

    // Enum to give the user a dropdown-like selection (0 for Car, 1 for Bike)
    enum VehicleType { Car, Bike }

    constructor(string memory _agencyName) {
        // Deploy both child contracts automatically when setting up the system
        carContract = new CarRental(_agencyName);
        bikeContract = new BikeRental(_agencyName);
    }

    // Function to select vehicle type and calculate rent
    function rentVehicle(VehicleType _type, uint _days) public {
        if (_type == VehicleType.Car) {
            // Calls the overridden function in CarRental
            currentCalculatedRent = carContract.calculateRent(_days, msg.sender);
        } else if (_type == VehicleType.Bike) {
            // Calls the overridden function in BikeRental
            currentCalculatedRent = bikeContract.calculateRent(_days, msg.sender);
        }
    }
}
