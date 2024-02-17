// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Comparisons {

    /// @notice Returns value == 0.
    function isZero(int256 value) public pure returns (bool isZero_) {
        assembly {
           isZero_ := iszero(value) 
        }
    }

    /// @notice Returns lhs > rhs.
    function greaterThan(uint256 lhs, uint256 rhs)
        public
        pure
        returns (bool greater)
    {
        assembly {
            greater := gt(lhs,rhs)
        }
    }

    /// @notice Returns lhs < rhs.
    function signedLowerThan(
        int256 lhs, 
        int256 rhs
    ) public pure returns (bool lower) {
        assembly {
            lower := slt(lhs, rhs)
        }
    }

    /// @notice Returns true if value < 0 or value == 10, false otherwise.
    function isNegativeOrEqualTen(
        int256 value
    ) public pure returns (bool negativeOrEqualTen) {
        assembly {
            let x
            if slt(value, 0) { x := true }
            if eq(value, 10) { x := true }
            if eq(x, true) {negativeOrEqualTen := true }
            switch x 
            case true {negativeOrEqualTen := true }
            default { negativeOrEqualTen := false }
        }
    }

    /// @return inRange true if lower <= value <= upper, false otherwise
    function isInRange(
        int256 value,
        int256 lower,
        int256 upper
    ) public pure returns (bool inRange) {
        assembly {
            if and(
                or(sgt(value, lower),eq(value, lower)),
                or(slt(value, upper),eq(value, upper))
                ) 
                {inRange := true }

        }
    }
}
