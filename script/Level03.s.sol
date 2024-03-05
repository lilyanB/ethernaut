// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {CoinFlip} from "../src/Level03.sol";
import {Attack} from "../src/Level03Attack.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack(CoinFlip(vm.envAddress("LVL03_ADDR")));

        console2.log("attacker address: ", address(attack));

        vm.stopBroadcast();
    }
}

contract Level03 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        CoinFlip instance = CoinFlip(vm.envAddress("LVL03_ADDR"));
        Attack attack = Attack(vm.envAddress("LVL03ATTACK_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console2.log("consecutiveWins: ", instance.consecutiveWins());
        attack.flipAttack();
        console2.log("consecutiveWins: ", instance.consecutiveWins());

        vm.stopBroadcast();
    }
}

contract Submit is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        CoinFlip instance = CoinFlip(payable(vm.envAddress("LVL03_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        ethernaut.submitLevelInstance(address(instance));
        console2.log("Level03: Success");

        vm.stopBroadcast();
    }
}
