// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RobineToken is ERC20, Ownable {
    constructor(uint256 totalSupply_) ERC20("RobineToken", "RBT") {
        _mint(msg.sender, totalSupply_);
    }
}
