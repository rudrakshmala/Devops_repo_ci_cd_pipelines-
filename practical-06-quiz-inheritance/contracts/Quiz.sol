// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Quiz {
    struct Question {
        string questionText;
        string correctAnswer;
    }

    // Array to store all quiz questions
    Question[] public questions;

    // Mappings to track scores per user
    mapping(address => uint) public correctAnswers;
    mapping(address => uint) public incorrectAnswers;

    // 1. Function to create/add a quiz question
    function addQuestion(string memory _text, string memory _answer) public {
        questions.push(Question(_text, _answer));
    }

    // 2. Function to answer a specific question by its index
    function answerQuestion(uint _questionIndex, string memory _userAnswer) public {
        require(_questionIndex < questions.length, "Invalid question index");

        // Compare the strings using keccak256 hashes
        if (keccak256(bytes(questions[_questionIndex].correctAnswer)) == keccak256(bytes(_userAnswer))) {
            correctAnswers[msg.sender]++;
        } else {
            incorrectAnswers[msg.sender]++;
        }
    }

    // 3. Helper function to check total questions available
    function getTotalQuestions() public view returns (uint) {
        return questions.length;
    }
}
