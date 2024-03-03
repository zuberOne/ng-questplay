// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract WhispersV1 {

    /// @notice Read and return the uint256 appended behind the expected calldata.
    function whisperUint256() external pure returns (uint256 value) {
        assembly {
            value := calldataload(0x04)
        }
    }

    /// @notice Read and return the string appended behind the expected calldata.
    /// @dev The string is abi-encoded.
    function whisperString() external pure returns (string memory str) {
        assembly {

                let strPointer := calldataload(0x24)
                let strLength := add(strPointer,0x20)

                str := mload(0x40)
                calldatacopy(str,0x24,strLength)

                mstore(0x40, add(str, strLength))

        }
    }

}

