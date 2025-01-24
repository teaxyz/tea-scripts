// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {IProxyAdmin} from "src/IProxyAdmin.sol";

contract FundOwnerScript is Script {
    IProxyAdmin constant PROXY_ADMIN = IProxyAdmin(0x4200000000000000000000000000000000000018);

    function run() external {
        uint256 prefundedPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(prefundedPrivateKey);

        payable(PROXY_ADMIN.owner()).transfer(1 ether);

        vm.stopBroadcast();
    }
}
