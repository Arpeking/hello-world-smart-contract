// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CompteurSimple {
    uint256 public compteur;

    constructor() {
        compteur = 0;
    }

    function incrementer() public {
        compteur += 1;
    }

    function obtenirValeur() public view returns (uint256) {
        return compteur;
    }
}
