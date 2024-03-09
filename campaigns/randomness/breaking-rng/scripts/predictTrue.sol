// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../contracts_/Shadeling.sol";

contract predictTrue is Script {

    // Input bandit camp address here
    Shadeling constant SHADELING = Shadeling(0x50DD8869BcA4EF808F712B07E94EfEF99AB20CA9);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        SHADELING.predict(keccak256(abi.encode(block.timestamp)));

        vm.stopBroadcast();
    }
}