// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
 
 contract Animal{
    event log(string message);
 
    function getName() public virtual {
        emit log("Animal");
    }
    function getBread() public virtual {
        emit log("Not good Bread");
    }
 }
 contract Husky is Animal{
    function getName()public virtual override {
        emit log ("Husky");
    }
    function getBread()public virtual override {
        emit log ("Husky Bread");
        super.getBread();
    }
 }
 contract German is Animal{
    function getName()public virtual override  {
       emit log("German Shepherd");
    }
    function getBread()public virtual override {
        emit log("German Shepherd Bread");
        super.getBread();
    }
 }
 contract Bread is German,Husky{
    function getName() public override (Husky,German) {
        super.getName();
    }
    function getBread() public override (Husky,German) {
        super.getBread();
    }
 }
