// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

abstract contract Challenge {

    /**
     * @notice Returns a copy of the given array in a gas efficient way.
     * @dev This contract will be called internally.
     * @param array The array to copy.
     * @return copy The copied array.
     */
    function copyArray(bytes memory array) 
        internal 
        pure 
        returns (bytes memory copy) 
    {
        assembly {
            
            let fmp := mload(0x40)

            copy := fmp

            let arrayLength := mload(array)
            let totalLength := add(arrayLength,0x20)

            
            mstore(fmp, arrayLength)

            fmp := add(fmp, 0x20)

            let arrayIndex := add(array, 0x20)

            for {let i := 0} lt(i,arrayLength) {i := add(i,1)} {
                mstore(fmp, mload(arrayIndex))
                fmp := add(fmp,0x20)
                arrayIndex := add(arrayIndex,0x20)
            }

            mstore(0x40,fmp)
        }
         

    }
    
}
