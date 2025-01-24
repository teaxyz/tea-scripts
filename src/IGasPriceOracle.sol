// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGasPriceOracle {
    function setFallbackPrice(uint160) external;
    function getLatestPrice() external returns (uint96, uint160);
    function setOracleConfig(uint96, address) external;
}
