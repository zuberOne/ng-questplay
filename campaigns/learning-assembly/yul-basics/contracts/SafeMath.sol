// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SafeMath {

    /// @notice Returns lhs + rhs.
    /// @dev Reverts on overflow / underflow.

    
    function add(
        int256 lhs, 
        int256 rhs
    ) public pure returns (int256 result) {
        // Convert this to assembly
        assembly {
            result := add(lhs,rhs)
            if sgt(result,0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {revert(0,0)}
            if slt(result,0x8000000000000000000000000000000000000000000000000000000000000000) {revert(0,0)}
        }
    }

    /// @notice Returns lhs - rhs.
    /// @dev Reverts on overflow / underflow.
    function sub(int256 lhs, int256 rhs) public pure returns (int256 result) {

        // Convert this to assembly
        assembly {
            result := sub(lhs,rhs)
            if sgt(result,0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {revert(0,0)}
            if slt(result,0x8000000000000000000000000000000000000000000000000000000000000000) {revert(0,0)}
            if gt(rhs, sub(0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, lhs)) { revert(0, 0) }
        }
    }

    /// @notice Returns lhs * rhs.
    /// @dev Reverts on overflow / underflow.
    function mul(int256 lhs, int256 rhs) public pure returns (int256 result) {
        // Convert this to assembly
        assembly {
            result := mul(lhs,rhs)
            if sgt(result,0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {revert(0,0)}
            if slt(result,0x8000000000000000000000000000000000000000000000000000000000000000) {revert(0,0)}
        }
    }

    /// @notice Returns lhs / rhs.
    /// @dev Reverts on overflow / underflow.
    function div(int256 lhs, int256 rhs) public pure returns (int256 result) {
        // Convert this to assembly
        assembly {
            result := sdiv(lhs,rhs)
           // if or(lt(lhs,under),gt(result,sub(exp(2,256), 1))) {revert(0,0)}
            if sgt(result,0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {revert(0,0)}
            if slt(result,0x8000000000000000000000000000000000000000000000000000000000000000) {revert(0,0)}           
        }
    }
}
