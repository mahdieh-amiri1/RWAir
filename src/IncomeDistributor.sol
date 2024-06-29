// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Purpose: Distribute rental income to fractional token holders proportionally.

// Features:
// Receiving rental payments.
// Calculating and distributing payments to token holders.
// Handling payment splits and timing.

contract IncomeDistributor {
    IERC20 public propertyToken;
    mapping(address => uint256) public shares;
    uint256 public totalShares;

    constructor(address _propertyToken) {
        propertyToken = IERC20(_propertyToken);
    }

    function depositIncome() external payable {
        uint256 income = msg.value;
        for (uint i = 0; i < tokenHolders.length; i++) {
            address holder = tokenHolders[i];
            uint256 share = shares[holder];
            payable(holder).transfer((income * share) / totalShares);
        }
    }

    function updateShares(address holder, uint256 amount) external {
        shares[holder] = amount;
        totalShares += amount;
    }
}
