// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SimpleRaffle - tirage au sort parmi des inscrits
/// @notice Pseudo-aleatoire, NON sécurisé on-chain (miners/validators peuvent influer)
contract SimpleRaffle {
    address public immutable owner;
    address[] public participants;
    mapping(address => bool) public registered;
    address public winner;
    bool public drawn;

    event Registered(address indexed player);
    event WinnerDrawn(address indexed winner, uint256 indexed index);

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier notDrawn() {
        require(!drawn, "already drawn");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice S'inscrire une fois au tirage
    function register() external notDrawn {
        require(!registered[msg.sender], "already registered");
        registered[msg.sender] = true;
        participants.push(msg.sender);
        emit Registered(msg.sender);
    }

    /// @notice Tire un gagnant parmi les inscrits (owner seulement)
    function drawWinner() external onlyOwner notDrawn {
        uint256 n = participants.length;
        require(n > 0, "no participants");

        // *** PSEUDO-random: NE PAS utiliser pour des enjeux serieux ***
        uint256 rand = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp, address(this), n)
            )
        );
        uint256 index = rand % n;

        winner = participants[index];
        drawn = true;

        emit WinnerDrawn(winner, index);
    }

    /// @notice Nombre d'inscrits
    function participantsCount() external view returns (uint256) {
        return participants.length;
    }

    /// @notice Redémarrer un nouveau tirage (owner), efface les inscriptions et le gagnant
    function reset() external onlyOwner {
        delete winner;
        drawn = false;

        // libère le mapping et le tableau
        for (uint256 i = 0; i < participants.length; i++) {
            registered[participants[i]] = false;
        }
        delete participants;
    }
}
