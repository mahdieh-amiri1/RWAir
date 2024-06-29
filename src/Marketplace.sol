// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Purpose: Facilitate the buying and selling of fractional tokens.

// Features:
// Listing tokens for sale.
// Handling purchases and transfers.
// Managing escrow for transactions.
contract Marketplace {
    struct Listing {
        address seller;
        uint256 price;
        uint256 amount;
    }

    mapping(address => mapping(uint256 => Listing)) public listings;

    function listToken(address token, uint256 amount, uint256 price) external {
        listings[token][amount] = Listing(msg.sender, price, amount);
    }

    function buyToken(address token, uint256 amount) external payable {
        Listing memory listing = listings[token][amount];
        require(msg.value == listing.price, "Incorrect payment amount");
        IERC20(token).transferFrom(listing.seller, msg.sender, amount);
        payable(listing.seller).transfer(msg.value);
        delete listings[token][amount];
    }
}
