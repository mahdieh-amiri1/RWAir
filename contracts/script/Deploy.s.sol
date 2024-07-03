// scripts/Deploy.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/PropertyToken.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        // Example values for constructor parameters
        string memory name = "PropertyToken";
        string memory symbol = "PTK";
        address frax;// = 0xYourAdminAddress; // replace with your admin address
        address fsx;// = 0xYourAdminAddress; // replace with your admin address
 
        new PropertyToken(name, symbol, frax, fsx);

        vm.stopBroadcast();
    }
}
