# Ethereum-Will-SmartContract

## Project Overview
This Ethereum smart contract manages digital wills, allowing automatic inheritance distribution in Ether. It simplifies Ether transactions by converting values between Ether and Wei, ensuring easy interaction and precise control.

## Features
- Set inheritances in Ether for different beneficiaries.
- Automatically distribute inheritances upon the owner's declaration of deceased status.
- Convert values between Ether and Wei for ease of use.

## Prerequisites
- Solidity ^0.8.0
- Ethereum Wallet (e.g., MetaMask)
- [Remix Ethereum IDE](https://remix.ethereum.org/)

## Installation
1. Clone the repository or download the Solidity contract file.
2. Open Remix IDE and import the contract.
3. Compile and deploy the contract in a test or live Ethereum environment.

## Usage
- Set inheritances using `setInheritance` function.
- Declare the contract owner as deceased using `declareDeceased` function.
- View set inheritances and beneficiary wallets using view functions.

## Built With
- [Solidity](https://soliditylang.org/) - The core programming language.
- [Ethereum](https://ethereum.org/en/) - Blockchain platform for deployment.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
