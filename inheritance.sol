// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

 contract Base {
    uint public x;
    function setX(uint _x)public {
        x = _x;
    }
 }
 contract DellA is Base {
    function getX() public view returns (uint) {
        return  x;
    }
 }
 contract DellB is Base{
    function getXTimeTWO() public view returns (uint){
        return x * 2; 
    }
 }
