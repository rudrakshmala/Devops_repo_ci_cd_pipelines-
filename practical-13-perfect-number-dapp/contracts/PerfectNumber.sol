//SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

contract PerfectNumber {
    function checkPerfect(uint n) public pure returns (string memory) {
        uint sum = 0;
        for (uint i = 1; i <= n / 2; i++) {
            if (n % i == 0) {
                sum = sum + i;
            }
        }
        if (sum == n && n > 0) {
            return "Perfect Number";
        } else {
            return "Not a Perfect Number";
        }
    }
}
