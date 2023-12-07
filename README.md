Game Item Smart Contract

This smart contract is designed to create an ERC1155 token system where each wallet can possess one of the main tokens, and these main tokens are soulbound. Additionally, many item tokens can be transacted between wallets that possess the soulbound main token.
Setup

To set up this contract, you will need the following:

Deployment

Install Foundry by running the bash command

    curl -L https://foundry.paradigm.xyz | bash

    foundryup

Clone the repository:

    git clone https://github.com/the-first-elder/Gamer-Token-ERC1155.git

Install dependencies:

    cd Gamer_ERC1155

    forge install

<!-- A Solidity development environment Visual Studio Code.
The OpenZeppelin library, which provides implementations of standards like ERC20 and ERC1155.
Test ETH in your wallet for the deployment. -->

Contract Overview

The smart contract consists of two main types of tokens:

    Main Token: This token represents a character in the game context. The main token is soulbound, meaning it is unique to each wallet that owns it.

    Item Tokens: These tokens can only be transacted between wallets that possess the main token. To enforce this rule, the safeTransferFrom function is overridden to check if the recipient has the main token before allowing the transfer They Include EARTH, WATER, FIRE.

Usage

To interact with the contract, you can call the following functions:

    mintSoulBound(bytes data): This function returns the balance of a specific token id for a given account.

    sendOtherTokens(to, id, amount, data): This function transfers a specified amount of a specific token from one address to another, and includes optional data that can be used to execute additional functionality on the receiving end.

License

This project is licensed under the MIT License - see the LICENSE.md file for details.
Acknowledgements

This project was created as part of the Blockchain Developer Bootcamp by Phind.
