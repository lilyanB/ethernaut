// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint256 x;
        assembly {
            x := extcodesize(caller())
        }
        // get the size of the code at the address of the caller(like msg.sender in solidity)
        // if the caller is a contract, the size will be greater than 0 if it's already deployed
        // so, wee need run transaction from an EOA or in constructor of a contract
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
        // keccak256(abi.encodePacked(msg.sender)) returns the address of the caller
        // bytes8(keccak256(abi.encodePacked(msg.sender)) returns the first 8 bytes of the address donc b1 b2 b3 b4 b5 b6 b7 b8
        // uint64(bytes8(keccak256(abi.encodePacked(msg.sender))) returns the first 8 bytes of the address as an integer
        // uint64(_gateKey) returns the first 8 bytes of the gate key as an integer
        // with ^, we compare the first 8 bytes of the address with the first 8 bytes of the gate key

        // type(uint64).max is the maximum value of uint64 (0xFFFFFFFFFFFFFFFF)

        // donc si uint64(bytes8(keccak256(abi.encodePacked(msg.sender))) ^ uint64(_gateKey) == type(uint64).max alors b1 b2 b3 b4 b5 b6 b7 b8 ^ b1 b2 b3 b4 b5 b6 b7 b8 == 0xFFFFFFFFFFFFFFFF
        // or a ^ b == 0xFFFFFFFFFFFFFFFF
        // donc b == a ^ 0xFFFFFFFFFFFFFFFF
        // donc nous avons qu'a calculer a ^ 0xFFFFFFFFFFFFFFFF pour trouver b
        // a = uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
