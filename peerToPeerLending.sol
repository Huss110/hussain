// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./safeMaths.sol";
import "./Cradit.sol";

contract peerToPeerLending is Ownable{
    using SafeMath for uint;

    struct User{
        bool Credited;
        
        address activeCredit;

        bool fraudStatus;

        address[] allCredits;
    }

    mapping(address => User) public users;

    address[] public credits;
    
    event logCreditCreated(address indexed _address, address indexed _borrower, uint indexed timestamp);
    event logCreditStateChanged(address indexed _address, Credit.State indexed state, uint indexed timestamp);
    event logCreditActiveChanged(address indexed _address, bool indexed active, uint indexed timestamp);
    event logUserSetFraud(address indexed _address, bool fraudStatus, uint timestamp);

    function applyForCredit(uint requestedAmount, uint repaymentsCount, uint interest, bytes memory creditDescripton) public returns (address _credit){
        require(users[msg.sender].credited == false);

        require(users[msg.sender].fraudStatus == false);

        assert(users[msg.sender].activeCredit == address(0));

        users[msg.sender].credited = true;

        Credit credit = new Credit(requestedAmount, repaymentsCount, interest, creditDescripton);

        users[msg.sender].activeCredit = address(credit);

        credits.push(address(credit));

        users[msg.sender].allCredits.push(address(credit));

        emit logCreditCreated(address(credit), msg.sender, block.timestamp);

        return address(credit);
    }

    function getCredits() public view returns (address[] memory){
        return credits;
    }

    function getUserCredits() public view returns (address[] memory){
        return users[msg.sender].allCredits;
    }

    function setFraudStatus(address _borrower) external returns (bool){

        users[_borrower].fraudStatus= true;

        emit logUserSetFraud(_borrower, users[_borrower].fraudStatus, block.timestamp);

        return users[_borrower].fraudStatus;
    }

    function changeCreditState(Credit _credit, Credit.State state) public onlyOwner{

        Credit credit = Credit(_credit);
        credit.changeState(state);

        emit logCreditStateChanged(address(credit), state, block.timestamp);
    }

    function changeCreditState(Credit _credit) public onlyOwner{
        Credit credit = Credit (_credit);
        bool active = credit.toggleActive();

        emit logCreditActiveChanged(address(credit), active, block.timestamp);
    }
}
