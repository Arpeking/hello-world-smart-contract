// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Simple HelloWorld smart contract
contract HelloWorld {
    // Fonction qui retourne un message "Hello, World!"
    function sayHello() public pure returns (string memory) {
        return "Hello, World!";
    }
}
