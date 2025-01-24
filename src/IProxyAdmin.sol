// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IProxyAdmin {
    function owner() external view returns (address);
    function transferOwnership(address newOwner) external;
}
