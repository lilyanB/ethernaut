// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        // https://book.getfoundry.sh/forge/gas-reports for view gas in test
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        //bytes8 : 0x b1 b2 b3 b4 b5 b6 b7 b8
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        // uint64(_gateKey) récupère les 8 derniers(donc tous) bytes(64 bits) de _gateKey donc b1 b2 b3 b4 b5 b6 b7 b8
        // uint32(uint64(_gateKey)) récupère les 4 derniers bytes(4*8=32 bits) de _gateKey donc b5 b6 b7 b8
        // uint16(uint64(_gateKey)) récupère les 2 derniers bytes(2*8=16 bits) de _gateKey donc b7 b8
        // donc si uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)) alors b5 b6 b7 b8 == b7 b8
        // donc b5 b6 == 00 00
        // donc b7 b8 != 00 00

        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        // si uint32(uint64(_gateKey)) != uint64(_gateKey) alors b5 b6 b7 b8 != b1 b2 b3 b4 b5 b6 b7 b8
        // donc b1 b2 b3 b4 != 00 00 00 00
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        // uint160(tx.origin) récupère les 20 derniers bytes(20*8=160 bits) de tx.origin donc b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20
        // uint16(uint160(tx.origin)) récupère les 2 derniers bytes(2*8=16 bits) de tx.origin donc b19 b20
        // uint32(uint64(_gateKey)) récupère les 4 derniers bytes(4*8=32 bits) de _gateKey donc b5 b6 b7 b8
        // donc si uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)) alors b5 b6 b7 b8 == b19 b20
        // donc b5 b6 == 00 00

        // finalement _gateKey doit être de la forme 0x b1 b2 b3 b4 0 0 b7 b8 où b7 b8 == b19 b20 et b19 b20 proviens de tx.origin.
        // _gateKey = 0x b1 b2 b3 b4 00 00 + b7 b8
        // _gateKey = 0x b1 b2 b3 b4 00 00 + b19 b20

        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
