// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGPGWallet {
    function addSigner(
        address signer,
        uint256 paymasterFee,
        uint256 deadline,
        bytes32 salt,
        bytes memory pubKey,
        bytes memory signature
    ) external;
}
