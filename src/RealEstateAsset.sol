// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// Purpose: Represent unique real estate properties for registration and management.

// Features:
// Minting and transferring unique property tokens.
// Linking to metadata that describes property details.
contract RealEstateAsset is ERC721 {
    uint256 public nextTokenId;
    address public owner;

    constructor() ERC721("RealEstateAsset", "REA") {
        owner = msg.sender;
    }

    function mint(address to) external {
        require(msg.sender == owner, "Only owner can mint");
        _mint(to, nextTokenId);
        nextTokenId++;
    }
}
