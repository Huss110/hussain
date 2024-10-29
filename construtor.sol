// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract huss {
    uint public year;
    string public month;
    constructor(uint u1, string memory s1){
        year =u1;
        month =s1;
    }

}
contract huss1 {
    uint public date;
    string public day;
    bool public summer;
    constructor( uint u2, string memory s2, bool b){
        date =u2;
        day =s2;
        summer =b;
    }
}

contract child1 is huss(2024, "april"), huss1(6,"friday", true){

}

contract child2 is huss,huss1{
    constructor(uint u1,string memory s1,uint u2, string memory s2, bool b) huss(u1,s1)huss1(u2,s2,b) {
        
    }
}
