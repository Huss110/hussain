// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Animal {
    string private name;

    constructor(string memory _name) {
        name = _name;
    }

    function getName() public view returns (string memory) {
        return name;
    }
}

contract Dog is Animal {
    string private breed;

    constructor(string memory _name, string memory _breed) Animal(_name) {
        breed = _breed;
    }

    function getBreed() public view returns (string memory) {
        return breed;
    }
}

contract TestDogs {
    Dog public husky;
    Dog public germanShepherd;

    constructor() {
        husky = new Dog("Husky", "Husky");
        germanShepherd = new Dog("German Shepherd", "German Shepherd");
    }

    function getHuskyDetails() public view returns (string memory, string memory) {
        return (husky.getName(), husky.getBreed());
    }

    function getGermanShepherdDetails() public view returns (string memory, string memory) {
        return (germanShepherd.getName(), germanShepherd.getBreed());
    }
}
