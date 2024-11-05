// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Ownable{
    address public owner;

    event logOwnershipTransfered(address indexed _currentOwner,address indexed _newOwner);

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }  

    constructor() {
        owner = msg.sender;
    }
}