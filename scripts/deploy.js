const hre = require("hardhat");

async function main() {
  const ICOToken = await hre.ethers.getContractFactory("ICOToken");
  const icoToken = await ICOToken.deploy("1000000000000000000000000");


  const ICOExchange = await hre.ethers.getContractFactory("ICOExchange");
  const icoExchange = await ICOExchange.deploy();


  const ICONft = await hre.ethers.getContractFactory("ICONft");
  const icoNft = await ICONft.deploy(100);

  await icoToken.deployed();
  await icoExchange.deployed();
  await icoNft.deployed();

  console.log(`IcoToken Deployed at Address ${icoToken.address}`);
  console.log(`IcoExchange Deployed at Address ${icoExchange.address}`);
  console.log(`IcoNft Deployed at Address ${icoNft.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});