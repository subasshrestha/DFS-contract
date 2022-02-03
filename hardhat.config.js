require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
      ropsten: {
          url: 'https://eth-ropsten.alchemyapi.io/v2/Z9tl8Pn65pfenezvdBUwjYEDEjpR6NYm',
          accounts: ['529ce94e6a3e489b4dfd61be6e5673c123de884f3f21a8f224a53c8b1676037b']
      }
  }
};
