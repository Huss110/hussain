// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Indentity{
    uint public age;
    string public name;
    constructor(uint _age , string memory _name) {
        age =_age;
        name =_name;
    }
    // function Hussainage()public  view returns (uint) {
    //     return age;
    // }
    // function Hussainname()public view returns (string memory){
    //   return name;}
}

