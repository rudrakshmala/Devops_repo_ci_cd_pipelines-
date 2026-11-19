// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Voting {
    uint256 public modiVotes;
    uint256 public gandhiVotes;

    mapping(address => bool) public hasVoted;

    function vote(string memory candidate) public {
        require(!hasVoted[msg.sender], "You have already voted");

        if (keccak256(bytes(candidate)) == keccak256(bytes("Modi"))) {
            modiVotes++;
        } else if (keccak256(bytes(candidate)) == keccak256(bytes("Gandhi"))) {
            gandhiVotes++;
        } else {
            revert("Candidate does not exist. Vote 'Modi' or 'Gandhi'");
        }

        hasVoted[msg.sender] = true;
    }

    function getWinner() public view returns (string memory) {
        if (modiVotes > gandhiVotes) {
            return "Modi";
        } else if (gandhiVotes > modiVotes) {
            return "Gandhi";
        } else {
            return "Tie";
        }
    }
}
