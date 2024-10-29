// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    // Event to log deposits
    event Deposited(address indexed sender, uint amount);
    // Event to log withdrawals
    event Withdrawn(address indexed recipient, uint amount);

    // Function to accept Ether
    receive() external payable {
        require(msg.value > 0, "Must send some Ether");
        emit Deposited(msg.sender, msg.value);
    }

    // Function to check the balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function to transfer Ether to another address
    function transferEther(address payable _recipient, uint _amount) public {
        // Ensure the amount is greater than 0
        require(_amount > 0, "Amount must be greater than 0");
        
        // Check if the contract has sufficient balance
        require(_amount <= address(this).balance, "Insufficient balance in contract");
        
        // Perform the transfer
        (bool success, ) = _recipient.call{value: _amount}("");
        require(success, "Transfer failed");

        emit Withdrawn(_recipient, _amount);
    }
}
