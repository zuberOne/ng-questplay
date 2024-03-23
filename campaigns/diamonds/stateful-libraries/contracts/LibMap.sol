// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library LibMap {

        struct Map {
            string currentLocation;
            mapping(string => mapping(string => bool)) knownPath;
        }
       
        bytes32 constant mapStorage = keccak256('encepencewdrugiejrece');

        function getMap()  internal pure returns (Map storage mapMap) {

            bytes32 mapPointer = mapStorage;
            assembly {
                mapMap.slot := mapPointer
            }
        }

    /// @notice Adds the path `from -> to` to the set of known paths.
    function addPath(string memory from, string memory to) internal {
        //ASSSEMLBY
        if (bytes(getMap().currentLocation).length == 0) {
            getMap().currentLocation = "harbor";
        }
        getMap().knownPath[from][to] = true;
        // IMPLEMENT THIS
    }

    /// @notice If the path `currentLocation() -> to` is known, sets current location as `to` and returns true.
    /// If path is not known, returns false.
    function travel(string memory to) internal returns (bool) { 
        if (getMap().knownPath[currentLocation()][to] = true) { 
            getMap().currentLocation = to;
            return true;
        }
        else {
            return false;
            }

        // IMPLEMENT THIS
    }

    /// @notice Returns current location.
    /// Initially set to "harbor".
    function currentLocation() internal view returns (string memory) {
        // IMPLEMENT THIS

        return getMap().currentLocation;
    }

}