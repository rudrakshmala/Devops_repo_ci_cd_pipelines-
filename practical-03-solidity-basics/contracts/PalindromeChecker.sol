// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract PalindromeChecker {
    function isPalindrome(uint n) public pure returns (bool) {
        uint reversed = 0;
        uint original = n;
        uint remainder;

        // Loop to reverse the number mathematically
        while (n != 0) {
            remainder = n % 10;
            reversed = reversed * 10 + remainder;
            n /= 10;
        }

        // Returns true if the original number matches the reversed number
        return original == reversed;
    }
}
