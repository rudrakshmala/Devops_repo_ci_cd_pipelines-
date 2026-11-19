// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 1. Parent Contract: Handles campaign configuration and details
contract CampaignDetails {
    address payable public owner;
    uint public fundingGoal;
    uint public deadline;

    // Initialize owner, goal, and deadline (duration in days)
    constructor(uint _fundingGoalInWei, uint _durationInDays) {
        owner = payable(msg.sender);
        fundingGoal = _fundingGoalInWei;
        deadline = block.timestamp + (_durationInDays * 1 days);
    }
}

// 2. Child Contract: Handles contribution logic, refunds, and events
contract Crowdfunding is CampaignDetails {
    uint public totalFunds;
    mapping(address => uint) public contributions;
    bool public goalReachedEmitted; // Ensures the goal event only emits once

    // Events
    event ContributionReceived(address indexed contributor, uint amount);
    event GoalReached(uint totalFunds);
    event RefundIssued(address indexed contributor, uint amount);

    // Pass arguments to the parent constructor
    constructor(uint _fundingGoalInWei, uint _durationInDays)
        CampaignDetails(_fundingGoalInWei, _durationInDays) {}

    // Allow users to contribute ETH
    function contribute() public payable {
        require(block.timestamp < deadline, "Campaign deadline has passed");
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        // Check if the goal is reached for the first time
        if (totalFunds >= fundingGoal && !goalReachedEmitted) {
            emit GoalReached(totalFunds);
            goalReachedEmitted = true;
        }
    }

    // Allow users to get a refund if the deadline passed and goal wasn't met
    function refund() public {
        require(block.timestamp > deadline, "Campaign is still active");
        require(totalFunds < fundingGoal, "Funding goal was reached, no refunds available");

        uint amountToRefund = contributions[msg.sender];
        require(amountToRefund > 0, "You have no contributions to refund");

        // Set balance to 0 BEFORE transferring to prevent Re-entrancy attacks
        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amountToRefund);

        emit RefundIssued(msg.sender, amountToRefund);
    }

    // Allow the owner to withdraw funds if the campaign was successful
    function withdrawFunds() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(totalFunds >= fundingGoal, "Funding goal not reached yet");

        uint amount = address(this).balance;
        require(amount > 0, "No funds available to withdraw");

        owner.transfer(amount);
    }
}
