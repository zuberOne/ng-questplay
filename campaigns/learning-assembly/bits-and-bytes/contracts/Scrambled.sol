// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Scrambled {

    /// @notice Recover an address that has been scrambled...
    function recoverAddress(bytes32 value)
        public
        pure
        returns (address rvalue)
    {
        assembly {
            // move source 1 byte to the right
            value := shr(8, value)

            // copy bits to rvalue
            rvalue := and(value, 0xFFFFFFFFFFFFFFFF)
            // move source 10 bytes to the right
            value := shr(80, value)
            let second := and(value, 0xFFFFFFFFFFFF)
            // move rvalue 6 bytes to the left 
            rvalue := shl(48, rvalue)
            // copy next bit part
            rvalue := or(rvalue, second)

            // move source x bytes to the right
            value := shr(mul(14, 8),value)
            let third := and(value, 0xFFFFFFFFFFFF)

            // move rvalue 6 bytes to the left 
            rvalue := shl(48,rvalue)

            rvalue := or(rvalue, third)



        }
    }
}


