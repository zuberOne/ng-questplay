// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract WhispersV2 {

    /// @notice Converts a compressed uint256 array into standard uint256[].
    function compressedWhisper() public pure returns (uint256[] memory array) {
        assembly {
       
           let arrayLength := 0

           let callDataIndex := 0x04

           let callData := 0

            let valueToAdd := 0
            let valueLength := 0
            let arrayLengthPointer := mload(0x40)
            let fmp := add(arrayLengthPointer,0x20)
            array := arrayLengthPointer     



           //let valueToAdd := and(shr(sub(256,mul(8,valueLength)),shl(8,callData)),0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)

            // end if there is nothing left
           //if eq(valueLength, 0) {}
            // increment array length
            
//lt(callDataIndex,sub(i,valueLength))
            for { let i := calldatasize() }  lt(callDataIndex,i) { fmp := add(fmp, 0x20 )} {
                callData := calldataload(callDataIndex)
                valueLength := byte(0,callData)
                arrayLength := add(arrayLength,1) 

                // ugly i know
                valueToAdd := and(shr(sub(256,mul(8,valueLength)),shl(8,callData)),0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
                if eq(valueLength,32)  {
                    callDataIndex := add(callDataIndex,0x01)
                    valueToAdd := calldataload(callDataIndex)
                    }
                
                callDataIndex := add(add(callDataIndex,0x01), mul(0x01,valueLength)) 
                mstore(fmp, valueToAdd)

            }

            mstore(arrayLengthPointer,arrayLength)



          let totalArrayLength := add(0x40,mul(arrayLength, 0x20))

          mstore(0x40, add(fmp, totalArrayLength))


        

        }
    }

}
