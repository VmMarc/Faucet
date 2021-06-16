//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./RobinetToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Faucet is Ownable {
    mapping(address => uint256) private _claimTokens;
    RobinetToken private _Robinet;
    uint256 private _deadLine;
    uint256 private _timeLeft;
    uint256 private _supplyInSale;

    event RobinetTransfer(address indexed sender, uint256 amount);

    constructor(address _Robinet) {
        _Robinet = RobinetToken(robinet);
        _deadLine = 3 days;
        _supplyInStock = _Robinet.balanceOf(owner());
    }

    modifier goodTime() {
        require(_claimTokens[msg.sender] >= block.timestamp, "Faucet: You need to wait 3 days before reclaim new Tokens");
        _;
    }

    function claim() public goodTime() {
        require(_supplyInStock != 0, "Faucet: No more Token to claim");
        _claimTokens[msg.sender] = block.timestamp + _deadLine;
        uint256 amountRobinet = 100;
        robinet.transferFrom(owner(), msg.sender, amountRobinet);
        emit RobinetTransfer(msg.sender, amountRobinet);
    }

    function timeLeft() public view returns (uint256) {
        return timeLeft = (_claimTokens[msg.sender] - block.timestamp);
    }
}
