// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Hussain 
{
    uint public age=20;

    function get() public view returns (uint)
    {
        return age;
    }

    function set(uint newage) public 
    {
        age=newage;
    }
}
