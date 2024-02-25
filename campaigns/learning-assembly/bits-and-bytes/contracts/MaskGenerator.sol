// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MaskGenerator {
    
    /// @notice Generates a mask.
    /// @param nBytes Width of mask in bytes.
    /// @param at Start of bytemask (little endian index)
    /// @param reversed If true, bytemask is a mask of 0s. Otherwise, bytemas,k is a regular mask of 1s.
    /// @dev Should revert if (`nBytes` + `at` > 32)
    function generateMask(
        uint256 nBytes,
        uint256 at,
        bool reversed
    ) public pure returns (uint256 mask) {
        assembly {
            if gt(add(nBytes, at), 32) { revert (0,0) }


            // shift left by width, then sub to pad with 1 to the right
            mask := sub(shl(mul(nBytes, 8), 1), 1)

            // shift left by index
            mask := shl(mul(at, 8), mask)
            
            if reversed { mask := xor(not(0), mask)} 
            
        }
    }
}
