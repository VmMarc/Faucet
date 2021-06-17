/* eslint-disable space-before-function-paren */
/* eslint-disable no-undef */
const hre = require('hardhat');
const { deployed } = require('./deployed');

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // Optionnel car l'account deployer est utilisé par défaut
  const [deployer] = await ethers.getSigners();
  console.log('Deploying contracts with the account:', deployer.address);

  // We get the Token contract to deploy
  const RobineToken = await hre.ethers.getContractFactory('RobineToken');
  const robineToken = await RobineToken.deploy(ethers.utils.parseEther('1000000'));

  // Attendre que le contrat soit réellement déployé, cad que la transaction de déploiement
  // soit incluse dans un bloc
  await robineToken.deployed();

  // update deployed.json and print usefull information on the console.
  await deployed('RobineToken', hre.network.name, robineToken.address);

  // We get the Faucet contract to deploy
  const Faucet = await hre.ethers.getContractFactory('Faucet');
  const faucet = await Faucet.deploy(robineToken.address);

  // Attendre que le contrat soit réellement déployé, cad que la transaction de déploiement
  // soit incluse dans un bloc
  await faucet.deployed();

  // update deployed.json and print usefull information on the console.
  await deployed('Faucet', hre.network.name, faucet.address);

  if (hre.network.name !== 'mainnet') {
    await robineToken.approve(`${faucet.address}`, ethers.utils.parseEther('1000000'));
    console.log((await robineToken.allowance(deployer.address, `${faucet.address}`))
      .toString(), `: Allowance to ${faucet.address}`);
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
