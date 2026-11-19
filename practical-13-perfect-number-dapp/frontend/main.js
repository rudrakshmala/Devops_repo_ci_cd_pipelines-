import { ethers } from "ethers";

const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

// Updated ABI to match the new pure function in your Solidity contract
const contractABI = [
  "function checkPerfect(uint256 n) public pure returns(string)"
];

let provider;
let signer;
let contract;

const connectWalletBtn = document.getElementById("connectWalletBtn");
const walletStatus = document.getElementById("walletStatus");
const checkNumBtn = document.getElementById("checkNumBtn");
const numInput = document.getElementById("numInput");
const txStatus = document.getElementById("txStatus");
const resultDisplay = document.getElementById("resultDisplay");

connectWalletBtn.addEventListener("click", async () => {
  provider = new ethers.BrowserProvider(window.ethereum);
  signer = await provider.getSigner();
  contract = new ethers.Contract(contractAddress, contractABI, signer);

  const address = await signer.getAddress();
  walletStatus.innerText = `Connected (${address})`;
});

checkNumBtn.addEventListener("click", async () => {
  if (!contract) {
    txStatus.innerText = "Connect wallet first!";
    return;
  }

  const numberToCheck = numInput.value;
  txStatus.innerText = "Checking...";

  try {
    // Calls the pure function and gets the string immediately
    const result = await contract.checkPerfect(numberToCheck);
    txStatus.innerText = "Check complete!";
    resultDisplay.innerText = result;
  } catch (error) {
    console.error(error);
    txStatus.innerText = "Failed! Enter a whole number and check the console (F12).";
  }
});
