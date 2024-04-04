// SPDX-License-Identifier: MIT

pragma solidity <0.7.0;

contract Attack {
    function attack() external {
        selfdestruct(payable(0));
    }
}
