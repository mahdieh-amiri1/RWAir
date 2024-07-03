// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";

contract ERC1155ToERC20Wrapper is ERC20, ERC1155Receiver {
    IERC1155 private erc1155;
    uint256 private tokenId;

    constructor(
        address _erc1155,
        uint256 _tokenId,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        erc1155 = IERC1155(_erc1155);
        tokenId = _tokenId;
    }

    function wrap(uint256 amount) external {
        erc1155.safeTransferFrom(msg.sender, address(this), tokenId, amount, "");
        _mint(msg.sender, amount);
    }

    function unwrap(uint256 amount) external {
        _burn(msg.sender, amount);
        erc1155.safeTransferFrom(address(this), msg.sender, tokenId, amount, "");
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }
}
