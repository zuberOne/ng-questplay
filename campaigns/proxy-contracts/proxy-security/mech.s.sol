// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

import "contracts_/BadMechSuit3.sol";

contract UseFuel is Script {

    // Input bandit camp address here
    BadMechSuit3 constant MECH = BadMechSuit3(0xD57129f4e7fAc4214aC80Df76d4ca0fadff175ee);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);


        MECH.upgradeTo(3);

        

        vm.stopBroadcast();
    }
}