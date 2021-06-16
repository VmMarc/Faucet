// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RobinetToken is ERC20 {
    
    constructor(address owner_) ERC20("RobinetToken", "RBT") {
        _mint(owner_, 1000000 * 10 ** decimals());
        _owner = owner_;
    }
}
