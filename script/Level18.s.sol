// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {MagicNum} from "../src/Level18.sol";

contract Level18 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        MagicNum instance = MagicNum(vm.envAddress("LVL18_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // need stack 42 in memory - to help: https://www.evm.codes/playground

        // store 42 in memory:
        // push 42 to the stack
        // need to push 1 byte (42) - variable 42 - PUSH1 - 0x60 --> PUSH1(0x2a) --> 0x602a (Pushing 2a or 42)
        // need to push 1 byte (24) - slot 24 - PUSH1 - 0x60 --> PUSH1(0x18) --> 0x6018 (Pushing an arbitrarily selected memory slot 24)
        // store the stack value in memory
        // MSTORE --> MSTORE --> 0x52 (Store value p=0x2a at position v=0x24 in memory)

        // return value from memory:
        // push in the stack where RETURN can find the value + number of bytes
        // PUSH1 32 bytes - 0x60 --> PUSH1(0x32) --> 0x6020 (pushing number of bytes of the value was stored in memory)
        // PUSH1 slot 24 - 0x60 --> PUSH1(0x24) --> 0x6018 (Pushing an arbitrarily selected memory slot 24)
        // RETURN - 0xF3 --> RETURN --> 0xf3 (Return 32 bytes from memory at slot 24)

        // OPCODE: 602a60185260206018f3 = 10 bytes

        // 602a60185260206018f3

        // copy the code in memory and return it
        // CODECOPY needs: select slot + byte offset + byte size to copy
        // PUSH1 byte size - PUSH1 10 - 0x69 --> PUSH1(0x0a) --> 0x600a (Pushing 10 bytes to copy)
        // PUSH1 ? - PUSH1 ? bytes - 0x60 --> PUSH1(0x00) --> need to know the offset, the starting position in memory
        // PUSH1 slot 5 - PUSH1 5 - 0x60 --> PUSH1(0x05) --> 0x6005 (Pushing an arbitrarily selected memory slot 5)
        // CODECOPY - 0x39 --> CODECOPY --> 0x39 (Copy 10 bytes from code at position 0 to memory with offset ?)

        // OPCODE: 600a_?_600539 = 6 bytes (need to know the offset = 1 byte)

        // return the code in memory
        // PUSH1 byte size - PUSH1 10 - 0x69 --> PUSH1(0x0a) --> 0x600a (Pushing 10 bytes to copy)
        // PUSH1 slot 5 - PUSH1 5 - 0x60 --> PUSH1(0x05) --> 0x6005 (Pushing an arbitrarily selected memory slot 5)
        // RETURN - 0xf3 --> RETURN --> 0xf3 (Return 10 bytes from memory at slot 5)

        // OPCODE: 600a6005f3 = 6 bytes

        // two opcodes: 600a_?_600539600a6005f3
        // two opcodes have 12 bytes
        // So ? = PUSH 0x0c (hex) = PUSH 12 (dec) = 0x600c

        // 600a600c600539600a6005f3

        // all opcodes: 600a600c600539600a6005f3602a60185260206018f3

        // to create SC: https://ethereum.stackexchange.com/questions/138243/solidity-assembly-code-create2-function

        bytes memory code = hex"600a600c600539600a6005f3602a60185260206018f3";
        bytes32 salt = bytes32(0);
        address solver;

        assembly {
            solver := create2(0, add(code, 0x20), mload(code), salt)
        }

        instance.setSolver(solver);
        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}
