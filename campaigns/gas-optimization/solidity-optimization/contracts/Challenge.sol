// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Challenge {

    uint256 private immutable _SKIP;

    constructor(uint256 skip) {
        _SKIP = skip;
    }

    /** 
     * @notice Returns the sum of the elements of the given array, skipping any SKIP value.
     * @param array The array to sum.
     * @return sum The sum of all the elements of the array excluding SKIP.
     */
    function sumAllExceptSkip(
        uint256[] calldata array
    ) public view returns (uint256 sum) {
                
        unchecked {
        // IMPLEMENT HERE
        for (uint256 i = 0; i < array.length; ++i) {

            if (array[i] != _SKIP) {
                uint256 nextSum = sum + array[i];
                if(nextSum < sum) {
                     revert();
                }
                sum = nextSum;
            }
    }
        return sum;
        }
    }

}
