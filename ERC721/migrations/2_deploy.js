const Colors = artifacts.require("./Color.sol");

module.exports = function (deployer) {
  deployer.deploy(Colors);
};
