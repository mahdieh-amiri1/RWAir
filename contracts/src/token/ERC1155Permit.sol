// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC1155Permit is ERC1155, EIP712, Ownable {
    using ECDSA for bytes32;

    mapping(address => uint256) public nonces;

    bytes32 private constant _PERMIT_TYPEHASH = keccak256(
        "Permit(address owner,address operator,uint256 id,bool approved,uint256 nonce,uint256 deadline)"
    );

    constructor(string memory uri) ERC1155(uri) EIP712("ERC1155Permit", "1") Ownable(msg.sender) {}

    function permit(
        address owner,
        address operator,
        uint256 id,
        bool approved,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        require(block.timestamp <= deadline, "ERC1155Permit: expired deadline");

        bytes32 structHash = keccak256(
            abi.encode(
                _PERMIT_TYPEHASH,
                owner,
                operator,
                id,
                approved,
                nonces[owner]++,
                deadline
            )
        );

        bytes32 hash = _hashTypedDataV4(structHash);
        address signer = hash.recover(v, r, s);
        require(signer == owner, "ERC1155Permit: invalid signature");

        _setApprovalForAll(owner, operator, approved);
    }
}
