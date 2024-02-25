// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Masks {

    /// @notice Set all the bits set in mask to 1 in x.
    function setMask(uint256 x, uint256 mask)
        public
        pure
        returns (uint256 rvalue)
    {
        assembly {
            rvalue := or(x, mask)
        }
    }

    /// @notice Set all the bits set in mask to 0 in x.
    function clearMask(uint256 x, uint256 mask)
        public
        pure
        returns (uint256 rvalue)
    {
        assembly {
            rvalue := and(x, not(mask))
        }
    }

    /// @notice Get 8 bytes from `x` starting from byte `at` (from the right).
    /// @param x value to extract 8 bytes from.
    /// @param at little endian index.
    function get8BytesAt(uint256 x, uint256 at)
        public
        pure
        returns (uint64 rvalue)
    {
        assembly {
            // shift right by 8xat bits then div 1 to move desired bits to the right side
            // apply a mask of length 8 bytes with and operator
            rvalue := and(0xFFFFFFFFFFFFFFFF ,shr(div(mul(at, 8), 1), x))
            }
    }
}


// Set lowest 4 bits to `1`setMask(0x5050505, 0xf) --> 0x505050f
// Clear lowest 5 bits to `0`clearMask(0x8118118, 0x1f) --> 0x8118100
// Get 8 bytes starting from the 2nd lowest byte get8BytesAt(0xdeadbeefdeadbeefdeadbeef, 1) --> 0xefdeadbeefdeadbe