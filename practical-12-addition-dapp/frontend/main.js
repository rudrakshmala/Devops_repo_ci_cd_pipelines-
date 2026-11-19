import { ethers } from "ethers";

// Replace with your deployed contract address from the terminal
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

const contractABI = [
  "function add(uint256 a, uint256 b) public pure returns (uint256)"
];

let provider;
let signer;
let contract;

const connectWalletBtn = document.getElementById("connectWalletBtn");
const walletStatus = document.getElementById("walletStatus");
const addBtn = document.getElementById("addBtn");
const resultDisplay = document.getElementById("resultDisplay");

connectWalletBtn.addEventListener("click", async () => {
  provider = new ethers.BrowserProvider(window.ethereum);
  signer = await provider.getSigner();
  contract = new ethers.Contract(contractAddress, contractABI, signer);

  const address = await signer.getAddress();
  walletStatus.innerText = `Connected (${address})`;
});

addBtn.addEventListener("click", async () => {
  if (!contract) {
    resultDisplay.innerText = "Connect wallet first!";
    return;
  }

  resultDisplay.innerText = "Calculating...";

  try {
    const numA = document.getElementById("numA").value;
    const numB = document.getElementById("numB").value;

    // Instantly calls the pure function (no gas fee, no MetaMask popup)
    const result = await contract.add(numA, numB);
    resultDisplay.innerText = result.toString();
  } catch (error) {
    console.error(error);
    resultDisplay.innerText = "Failed! Enter two whole numbers and check the console (F12).";
  }
});
