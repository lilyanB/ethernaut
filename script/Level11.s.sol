// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Elevator} from "../src/Level11.sol";
import {Attack} from "../src/Level11Attack.sol";

contract Level11 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        Elevator instance = Elevator(payable(vm.envAddress("LVL11_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        attack.attackElevator(address(instance));

        bool top = instance.top();
        if (top) {
            console2.log("Level11: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("call failed");
        }

        vm.stopBroadcast();
    }
}
