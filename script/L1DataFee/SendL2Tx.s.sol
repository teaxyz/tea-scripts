// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

contract SendL2Tx is Script {
    address immutable EOA = makeAddr("eoa");

    function run() external {
        uint256 ownerPrivateKey = vm.envUint("OWNER_PRIVATE_KEY");
        vm.startBroadcast(ownerPrivateKey);

        // 4 words * 32 bytes = 128 bytes
        bytes32 h = keccak256("hello");
        bytes memory cd = abi.encode(h, h, h, h);
        (bool s,) = EOA.call(cd);
        require(s);

        vm.stopBroadcast();
    }
}
