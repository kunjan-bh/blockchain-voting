# Blockchain Voting Smart Contract

This repository contains a simple **Blockchain Voting System** implemented as a Solidity smart contract.  
It allows users to securely vote for candidates, send Ether donations, and request refunds of their contributions — all managed on-chain.

## Features

- Register and vote for candidates with unique IDs  
- Track votes and candidates’ vote counts  
- Accept Ether donations using the `receive()` function  
- Implement a secure refund system for donors with balance tracking  
- Control voting status with an enum (`NotStarted`, `OnGoing`, `Ended`)  
- Protect critical functions using modifiers like `onlyOwner` and `onlyDuringVoting`  
- Handle unknown function calls gracefully with a fallback function  
- Emit events for votes, donations, refunds, and invalid calls

## Usage

- Compile and deploy the contract using [Remix IDE](https://remix.ethereum.org/)  
- Owner starts and ends the voting period  
- Users vote during the ongoing voting period  
- Supporters can donate Ether to the contract  
- Donors can refund their contributions securely anytime before the voting ends (optional feature)

## License

This project is licensed under the MIT License.  
Feel free to use, modify, and improve!

---

Built as a mini project to practice Solidity smart contract concepts including structs, mappings, modifiers, and Ether handling.

