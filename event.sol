// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserRegistry {
    // Struct to hold user information
    struct User {
        string name;
        uint age;
        bool exists;
    }

    // Mapping to store user data by address
    mapping(address => User) private users;

    // Events to log actions
    event UserAdded(address indexed userAddress, string name, uint age);
    event UserUpdated(address indexed userAddress, string name, uint age);
    event UserRemoved(address indexed userAddress);

    // Function to add a new user
    function addUser(string memory _name, uint _age) public {
        require(!users[msg.sender].exists, "User already exists");

        users[msg.sender] = User({
            name: _name,
            age: _age,
            exists: true
        });

        emit UserAdded(msg.sender, _name, _age);
    }

    // Function to update existing user information
    function updateUser(string memory _name, uint _age) public {
        require(users[msg.sender].exists, "User does not exist");

        users[msg.sender].name = _name;
        users[msg.sender].age = _age;

        emit UserUpdated(msg.sender, _name, _age);
    }

    // Function to remove a user
    function removeUser() public {
        require(users[msg.sender].exists, "User does not exist");

        delete users[msg.sender];

        emit UserRemoved(msg.sender);
    }

    // Function to get user information
    function getUser() public view returns (string memory name, uint age) {
        require(users[msg.sender].exists, "User does not exist");
        
        User memory user = users[msg.sender];
        return (user.name, user.age);
    }
}
