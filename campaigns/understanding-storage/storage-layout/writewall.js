const { ethers } = require("hardhat");

const TEMPLE_ADDRESS = "0x33Aa55F4C06DBC21dA52488B879769157A80c605"

const walletAddress = "0x85B0ec57a96b8B1fc48Bf70D1Fb9A6b4BAC5c0df"

const firstKey = 20

const secondKey = 22

const mappingSlot = 2

let walletAddressBytes32 = [];



// Function to calculate the slot of a nested mapping
function calculateNestedMappingSlot(firstKey, secondKey, mappingSlot) {
  // Convert key1 and slotOfFirstMapping to 32 bytes hex strings
  const key1Hex = ethers.utils.hexZeroPad(ethers.utils.hexlify(firstKey), 32);
  const slotHex = ethers.utils.hexZeroPad(ethers.utils.hexlify(mappingSlot), 32);

  // Hash key1 and the slot of the first mapping
  const hash = ethers.utils.keccak256(key1Hex + slotHex.substring(2)); // Remove '0x' from slotHex

  // Calculate final slot by adding key2 (as BigNumber for safety)
  const finalSlot = ethers.utils.hexZeroPad(ethers.utils.hexlify(ethers.BigNumber.from(hash).add(secondKey)), 32);

  return finalSlot;
}


async function main() {
  let finalSlot = "fed30fe70143b53ff40aad6bcc72b470f657073997bfb6d364f2956247948d73" ;
  let formattedAddress = ethers.utils.hexZeroPad(walletAddress, 32);
  walletAddressBytes32.push(formattedAddress);  
 
  const temple = await ethers.getContractAt(
    "Temple", TEMPLE_ADDRESS);   

  await temple.write(finalSlot, walletAddressBytes32[0]);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});