// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "contracts_/Temple.sol";

contract WriteWall is Script {


    address private myAddress = 0x85B0ec57a96b8B1fc48Bf70D1Fb9A6b4BAC5c0df;

    bytes32[] private addressStorage;


    // Input bandit camp address here
    Temple constant TEMPLE = Temple(0x1BaA53100f07AeAE15B735203734765Cfa244EfD);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");



        bytes32 convertedAddress = bytes32(uint256(uint160(myAddress)));

        addressStorage.push(convertedAddress);


        //bytes32 slotNumberBytes = keccak256(abi.encode(22, keccak256(abi.encode(20, uint256(2)))));
        //uint256 slotNumber = uint256(slotNumberBytes);
        uint256 slotNumber = 9;

        vm.startBroadcast(deployerPrivateKey);

        TEMPLE.write(slotNumber,addressStorage[0]);

        vm.stopBroadcast();
    }
}