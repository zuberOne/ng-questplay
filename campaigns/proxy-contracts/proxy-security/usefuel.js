const { ethers } = require("hardhat");

// Input bandit camp address here
const BANDIT_CAMP_ADDRESS = "0x3c7918aB88675C1e246174b17301a6c51fD37eD4"

async function main() {
  const mech = await ethers.getContractAt(
    "SuitLogicV0", BANDIT_CAMP_ADDRESS);

  await mech.consumeFuel();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});