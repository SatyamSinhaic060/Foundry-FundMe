# 💰 FundMe Smart Contract

This is a simple, secure Ethereum smart contract that allows users to fund the contract using ETH and enforces a minimum funding threshold based on real-time USD conversion using **Chainlink Price Feeds**.

## 🧠 Project Overview

This contract enables:
- Funding with ETH, enforcing a **minimum $5 USD** equivalent
- ETH/USD conversion using Chainlink Oracle
- Secure withdrawal by contract owner only
- Fallback and receive functions for ETH sent directly to the contract

---

## 🚀 Features

- ✅ Chainlink Price Feed Integration
- ✅ Immutable Owner
- ✅ Minimum Funding Enforcement (USD equivalent)
- ✅ Safe Withdrawals using `call`
- ✅ Gas-efficient error handling (`custom errors`)
- ✅ `fallback()` and `receive()` support
- ✅ Read-only getter functions for state variables

---

## 🛠️ Tech Stack

| Component      | Tool/Library                                 |
|----------------|----------------------------------------------|
| Language       | Solidity `^0.8.18`                           |
| Oracle         | [Chainlink Data Feeds](https://chain.link/) |
| Framework      | Hardhat / Foundry (recommended)             |
| Contract Utils | Custom `PriceConverter` Library             |

---

## 📁 Project Structure
fundme-smart-contract/
├── contracts/
│   ├── FundMe.sol                 # Main smart contract
│   ├── PriceConverter.sol         # Library for ETH/USD conversion
│   └── interfaces/
│       └── AggregatorV3Interface.sol # Chainlink oracle interface
│
├── scripts/
│   └── deploy.js                  # Script to deploy the contract 
│
├── test/
│   └── FundMe.test.js             # Unit tests for contract
│
├              
├── foundry.toml                   # Foundry config 
└── README.md                      # Project documentation

