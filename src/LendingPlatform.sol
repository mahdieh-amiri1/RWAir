// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Purpose: Allow users to borrow funds using their fractional tokens as collateral.

// Features:
// Depositing tokens as collateral.
// Issuing loans based on collateral value.
// Handling repayments and liquidations.
contract LendingPlatform {
    IERC20 public stablecoin;
    IERC20 public propertyToken;

    struct Loan {
        address borrower;
        uint256 collateralAmount;
        uint256 debtAmount;
    }

    mapping(address => Loan) public loans;

    constructor(address _stablecoin, address _propertyToken) {
        stablecoin = IERC20(_stablecoin);
        propertyToken = IERC20(_propertyToken);
    }

    function depositCollateral(uint256 amount) external {
        propertyToken.transferFrom(msg.sender, address(this), amount);
        loans[msg.sender].collateralAmount += amount;
    }

    function borrow(uint256 amount) external {
        require(loans[msg.sender].collateralAmount >= amount, "Insufficient collateral");
        stablecoin.transfer(msg.sender, amount);
        loans[msg.sender].debtAmount += amount;
    }

    function repay(uint256 amount) external {
        stablecoin.transferFrom(msg.sender, address(this), amount);
        loans[msg.sender].debtAmount -= amount;
    }

    function liquidate(address borrower) external {
        require(loans[borrower].debtAmount > loans[borrower].collateralAmount, "Cannot liquidate");
        propertyToken.transfer(msg.sender, loans[borrower].collateralAmount);
        delete loans[borrower];
    }
}
