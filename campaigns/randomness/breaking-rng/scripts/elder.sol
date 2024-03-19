// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../contracts_/ElderShadeling.sol";

contract commitPrediction is Script {

    // Input bandit camp address here
    ElderShadeling constant ELDERSHADELING = ElderShadeling(0xfaBd51d19E1e0BC06De07cDB43a2f234D5eA2089);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        ELDERSHADELING.commitPrediction(0x0000000000000000000000000000000000000000000000000000000000000000);

        vm.stopBroadcast();
    }
}