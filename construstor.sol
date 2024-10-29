// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract A{
    uint a = 1;
}

contract B is A{
    constructor(){
        a=2;
    }
}