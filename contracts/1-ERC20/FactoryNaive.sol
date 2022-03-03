// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/openzeppelin-contracts-upgradeable/contracts/token/ERC20/presets/ERC20PresetFixedSupplyUpgradeable.sol";

contract FactoryNaive {
    function createToken(
        string calldata _name,
        string calldata _symbol,
        uint256 _initialSupply
    ) external returns (address) {
        ERC20PresetFixedSupplyUpgradeable token = new ERC20PresetFixedSupplyUpgradeable();
        token.initialize(_name, _symbol, _initialSupply, msg.sender);
        return address(token);
    }
}
