// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/token/ERC20/ERC20.sol";


contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }
}
