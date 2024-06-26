// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;

    function setUp() public {
        token = new MyToken(1000);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1000);
    }
}
