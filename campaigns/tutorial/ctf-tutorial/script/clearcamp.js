const { ethers } = require("hardhat");

// Input bandit camp address here
const BANDIT_CAMP_ADDRESS = "0xA838F779584a7AbA47c7e87DbB3d7280C45859c7"

async function main() {
  const camp = await ethers.getContractAt(
    "BanditCamp", BANDIT_CAMP_ADDRESS);

  await camp.clearCamp();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});