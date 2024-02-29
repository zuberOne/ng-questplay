// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DynamicArray {

    /// @notice Copies `array` into a new memory array 
    /// and pushes `value` into the new array.
    /// @return array_ The new array to return.
    function push(
        uint256[] memory array, 
        uint256 value
    ) public pure returns (uint256[] memory array_) {
        assembly {

            // read free meme index
            let freeMemIndex := mload(0x40)

            // read array length
            let arrayLength := mload(array)
            // set index to read values
            let arrayIndex := add(array, 0x20)
            // add one position - push
            let newArrayLength := add(arrayLength, 1)
            // set new array 
            array_ := freeMemIndex
            // store the new lenght
            mstore(array_, newArrayLength)
            // increment index
            freeMemIndex := add(freeMemIndex, 0x20)
            // read and store
            for {let i := 0} lt(i, arrayLength) {i := add(i,1)} {
                
                mstore(freeMemIndex,mload(arrayIndex))

                freeMemIndex := add(freeMemIndex, 0x20)

                arrayIndex := add(arrayIndex, 0x20)

            }

            mstore(freeMemIndex, value)

            mstore(0x40, add(freeMemIndex, 0x20))


        }
    }

    /// @notice Pops the last element from a memory array.
    /// @dev Reverts if array is empty.
    function pop(uint256[] memory array) 
        public 
        pure 
        returns (uint256[] memory array_) 
    {
        assembly {


            let arrayLength := mload(array)
                        
            if lt(arrayLength,1) { revert (0,0)}

            mstore(array, sub(arrayLength,1))

            array_ := array

    }
    }

    /// @notice Pops the `index`th element from a memory array.
    /// @dev Reverts if index is out of bounds.
    function popAt(uint256[] memory array, uint256 index) 
        public 
        pure 
        returns (uint256[] memory array_) 
    {

        assembly {
            
            let arrayLength := mload(array)

            if or(lt(index, 0),gt(index, sub(arrayLength,1))) { revert(0,0)}

            let arrayIndex := add(add(array,0x20), mul(0x20, index))

            let newArrayLength := sub(arrayLength, 1)

            array_ := array

            mstore(array_, newArrayLength)


            for {let i := 0} lt(i, sub(arrayLength, index)) {i := add(i,1)} {
                
                mstore(arrayIndex,mload(add(arrayIndex,0x20)))

                arrayIndex := add(arrayIndex, 0x20)


            }            
          
        }
    }

}