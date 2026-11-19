import { ethers } from "ethers";

// ⚠ PASTE YOUR NEW DEPLOYED CONTRACT ADDRESS HERE
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

const contractABI = [
  "function isPrime(uint256 n) public pure returns (bool)"
];

let provider;
let signer;
let contract;

const connectWalletBtn = document.getElementById("connectWalletBtn");
const walletStatus = document.getElementById("walletStatus");
const checkBtn = document.getElementById("checkBtn");
const resultDisplay = document.getElementById("resultDisplay");

connectWalletBtn.addEventListener("click", async () => {
  provider = new ethers.BrowserProvider(window.ethereum);
  signer = await provider.getSigner();
  contract = new ethers.Contract(contractAddress, contractABI, signer);

  const address = await signer.getAddress();
  walletStatus.innerText = `Connected (${address})`;
});

checkBtn.addEventListener("click", async () => {
  if (!contract) {
    resultDisplay.innerText = "Connect wallet first!";
    return;
  }

  resultDisplay.innerText = "Checking...";
  resultDisplay.style.color = "black";

  try {
    const num = BigInt(document.getElementById("numInput").value);

    // Instantly calls the pure function (no gas fee)
    const isPrime = await contract.isPrime(num);

    if (isPrime) {
      resultDisplay.innerText = `${num} is a Prime Number! ✅`;
      resultDisplay.style.color = "green";
    } else {
      resultDisplay.innerText = `${num} is NOT a Prime Number. ❌`;
      resultDisplay.style.color = "red";
    }
  } catch (error) {
    console.error(error);
    resultDisplay.innerText = "Failed! Check Console (F12).";
    resultDisplay.style.color = "red";
  }
});
