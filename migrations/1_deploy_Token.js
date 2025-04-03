const ElonToken = artifacts.require("ElonToken");
module.exports =async function(deployer){
    const initialSupply = 1000000;
    await deployer.deploy(ElonToken, initialSupply);
    const MyTokenInstance = await ElonToken.deployed();
    console.log("my token deployed at: ", MyTokenInstance.address, "with initial supply of", initialSupply, "tokens")
}