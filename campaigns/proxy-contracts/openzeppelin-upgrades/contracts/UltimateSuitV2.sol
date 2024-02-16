// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract UltimateSuitV2 is ERC721Upgradeable {

    event Detonate(uint256 bombId);

    enum Status {
        CONFIRMED_BY_A,
        CONFIRMED_BY_B,
        LAUNCHED,
        DETONATED
    }

    struct BombStats {
        address target;
        uint256 damage;
        Status status;
        uint8 transfersLeft; // Transfers before bomb detonates        
    }


    address private pilotA;
    address private pilotB;

    uint256 public bombCount;
    mapping (uint => BombStats) private bombStats;

    uint8 constant TRANSFERS = 3;

    modifier isPilot(address _address) {
        require(_address == pilotA || _address == pilotB, "Not a pilot");
        _; 
    }

    modifier isUnconfirmed(uint256 _bombId, address _pilot) {
        require(_bombId < bombCount, "Bomb not initialized");

        Status expectedStatus = msg.sender == pilotA 
            ? Status.CONFIRMED_BY_B 
            : Status.CONFIRMED_BY_A;
        require(bombStats[_bombId].status == expectedStatus, "msg.sender already confirmed bomb");

        _; 
    }

    function initialize() external initializer {
        __ERC721_init("Ultimate Suit", "SUIT") ;          
    }

    function createBomb(
        address _target, 
        uint256 _damage
    ) public isPilot(msg.sender) returns (uint256 bombId) {
        _mint(address(this), bombCount);
        BombStats storage stats = bombStats[bombCount];
        stats.target = _target;
        stats.damage = _damage;
        stats.status = msg.sender == pilotA
            ? Status.CONFIRMED_BY_A
            : Status.CONFIRMED_BY_B;

        return bombCount++;
    }

    function confirmBomb(uint256 bombId) public 
        isPilot(msg.sender) 
        isUnconfirmed(bombId, msg.sender)
    {
        bombStats[bombId].status = Status.LAUNCHED;
        bombStats[bombId].transfersLeft = TRANSFERS;
        _transfer(
            address(this), 
            bombStats[bombId].target,
            bombId
        );
    }

    function getPilots() external view returns (address, address) {
        return (pilotA, pilotB);
    }
    
    function _transfer(
        address from, 
        address to, 
        uint256 bombId
    ) internal override {
        require(bombStats[bombId].status != Status.DETONATED, "Bomb already detonated");

        bombStats[bombId].transfersLeft--;
        if (bombStats[bombId].transfersLeft == 0) {
            emit Detonate(bombId);
            bombStats[bombId].status = Status.DETONATED;
        }
        super._transfer(from, to, bombId);
    }

}