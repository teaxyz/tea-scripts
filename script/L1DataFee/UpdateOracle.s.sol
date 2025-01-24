// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {FakeWETH, MockOracle} from "src/MockOracle.sol";
import {IGasPriceOracle} from "src/IGasPriceOracle.sol";

contract UpdateOracleScript is Script {
    IGasPriceOracle constant GAS_PRICE_ORACLE = IGasPriceOracle(0x420000000000000000000000000000000000000F);

    function run() external {
        uint256 ownerPrivateKey = vm.envUint("OWNER_PRIVATE_KEY");
        vm.startBroadcast(ownerPrivateKey);

        address weth = address(new FakeWETH());
        MockOracle oracle = new MockOracle(weth);

        GAS_PRICE_ORACLE.setOracleConfig(10, address(oracle));

        vm.stopBroadcast();
    }
}
