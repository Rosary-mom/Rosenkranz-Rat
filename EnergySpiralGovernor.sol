// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EnergySpiralGovernor {
    address public immutable owner;
    uint256 public lastR;           // R_Resilienz * 1e18
    uint256 public spiralFactor;    // aktueller c_gov-Wert
    event SpiralTriggered(uint256 rScaled, uint256 spiralValue, string action);

    constructor() { owner = msg.sender; }

    function updateResilience(uint256 rScaled) external {
        require(msg.sender == owner, "Only Rosenkranz-Rat");
        lastR = rScaled;
        spiralFactor = (rScaled * 314159265) / 1e18;   // π-Faktor für Spirale

        string memory action = (rScaled >= 85 * 1e16) 
            ? "GOLDEN_WINDOW_ENERGY_HARVESTING" 
            : "ROSENKRANZ_REDUNDANZ_SPIRALE_DREHT_WEITER";

        emit SpiralTriggered(rScaled, spiralFactor, action);
    }

    function getSpiralState() external view returns (uint256 r, uint256 spiral, string memory state) {
        state = (lastR >= 85 * 1e16) 
            ? "Energy Harvesting aktiviert – Goldenes Zeitalter" 
            : "Redundanz aktiv – Spirale dreht weiter";
        return (lastR, spiralFactor, state);
    }
}
