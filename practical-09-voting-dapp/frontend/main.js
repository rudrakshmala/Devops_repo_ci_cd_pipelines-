import { ethers } from "ethers";

// ⚠ PASTE YOUR DEPLOYED CONTRACT ADDRESS HERE
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

const contractABI = [
  "function vote(string candidate) public",
  "function getWinner() public view returns (string)",
  "function modiVotes() public view returns (uint256)",
  "function gandhiVotes() public view returns (uint256)"
];

let provider;
let signer;
let contract;

const connectWalletBtn = document.getElementById("connectWalletBtn");
const walletStatus = document.getElementById("walletStatus");
const txStatus = document.getElementById("txStatus");

connectWalletBtn.addEventListener("click", async () => {
  provider = new ethers.BrowserProvider(window.ethereum);
  signer = await provider.getSigner();
  contract = new ethers.Contract(contractAddress, contractABI, signer);

  const address = await signer.getAddress();
  walletStatus.innerText = `Connected (${address})`;

  // Automatically update vote counts on connect
  updateVoteCounts();
});

async function castVote(candidate) {
  if (!contract) {
    txStatus.innerText = "Connect wallet first!";
    return;
  }

  try {
    txStatus.innerText = "Please confirm transaction in MetaMask...";
    const tx = await contract.vote(candidate);

    txStatus.innerText = "Transaction sent! Waiting for confirmation...";
    await tx.wait(); // Wait for block to be mined

    txStatus.innerText = `Successfully voted for ${candidate}! ✅`;
    updateVoteCounts();
  } catch (error) {
    console.error(error);
    txStatus.innerText = "Failed! (Did you already vote?) ❌";
  }
}

document.getElementById("voteModiBtn").addEventListener("click", () => castVote("Modi"));
document.getElementById("voteGandhiBtn").addEventListener("click", () => castVote("Gandhi"));

document.getElementById("getWinnerBtn").addEventListener("click", async () => {
  if (!contract) return;
  const winner = await contract.getWinner();
  document.getElementById("winnerDisplay").innerText = winner;
});

async function updateVoteCounts() {
  if (!contract) return;
  const mVotes = await contract.modiVotes();
  const gVotes = await contract.gandhiVotes();
  document.getElementById("modiVotesDisplay").innerText = mVotes.toString();
  document.getElementById("gandhiVotesDisplay").innerText = gVotes.toString();
}
