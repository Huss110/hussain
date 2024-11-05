// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./safeMaths.sol";
import "./Ownable.sol";

contract Credit is Ownable{
    using safeMath for uint;

    address borrower;
    
    uint requestedAmount;
    uint returnAmount;
    uint repaidAmount;
    uint interest;

    uint requestedRepayments;
    uint remainingRepayments;
    uint repaymentInstallment;
    uint requestDate;
    uint lastRepaymentDate;

    bytes description;

    bool active = true;

    uint lendersCount = 0;
    uint revokeVotes = 0;

    uint revokTimeNeeded = block.timestamp + 1 seconds;

    uint fraudVotes = 0;

    mapping (address => bool) public lenders;

    mapping (address => uint) lendersInvestedAmount;

    mapping (address => bool) revokeVoters;

    mapping (address => bool) fraudVoters;

    enum State{
        investment,
        repayment,
        interestReturns,
        expired,
        revoked,
        fraud
    }
    State state;

    event logCreditInitialized(address indexed _address, uint indexed timpstamp);

    event logCreditStateChanged(State indexed state, uint indexed timpstamp);

    event logCreditStateActiveChanged(bool indexed active, uint indexed timestamp);

    event logBorrowerWithdrawal(address indexed _address, uint indexed _amount, uint indexed timestamp);

    event logBorrowerRepaymentInstallment(address indexed _address, uint indexed _amount, uint indexed timestamp);

    event logBorrowerRepaymentFinished(address indexed  _address, uint indexed  timestamp);

    event logBorrowerChangeReturned(address indexed  _address, uint indexed  _amount, uint indexed timestamp);

    event logLenderInvestment(address indexed  _address, uint indexed  _amount, uint indexed  timestamp);

    event logLenderWithdrawal(address indexed  _address, uint indexed  _amount, uint indexed  timestamp);

    event logLenderChangeReturned(address indexed  _address,uint indexed  _amount, uint indexed  timestamp);

    event logLenderVoteForRevoking(address indexed  _address,uint indexed timestamp);

    event logLenderVoteForFraud(address indexed  _address, uint indexed timestamp);

    event logLenderRefunded(address indexed  _address,uint indexed  _amount, uint indexed  timestamp);

    modifier isActive(){
        require(active == true);
        _;
    }

    modifier onlyBorrower(){
        require(msg.sender == borrower);
        _;
    }

    modifier onlyLender(){
        require(lenders[msg.sender] == true);
        _;
    }

    modifier canASkForInterest(){
        require(state == State.interestReturns);
        require(lendersInvestedAmount[msg.sender] > 0);
        _;
    }

    modifier canInvest(){
        require(state == State.investment);
        _;
    }

    modifier canRepay(){
        require(state == State.investment);
        _;
    }
    modifier canWithdraw(){
        require(address(this).balance >= requestedAmount);
        _;
    }
    
    modifier isNotFraud(){
        require(state != State.fraud);
        _;
    }

    modifier isRevokable(){
        require(block.timestamp >= revokTimeNeeded);
        require(state == State.investment);
        _;
    }

    modifier isRevoked(){
        require(state == State.revoked);
        _;
    }
    constructor (uint _requestedAmount,
    uint _requestedRepayments,
    uint _interest,
    bytes memory _description){
        borrower = tx.origin;
        interest = _interest;
        requestedAmount = _requestedAmount;
        requestedRepayments = _requestedRepayments;
        remainingRepayments = _requestedRepayments;

        returnAmount = requestedAmount.add(interest);

        repaymentInstallment = returnAmount.div(requestedRepayments);
        description = _description;
        requestDate = block.timestamp;

        emit logCreditInitialized(borrower, block.timestamp);
    }

    

    function getBalance() public  view returns (uint256){
        return address(this).balance;
    }

    function changeState(State _state) external onlyOwner{
        state = _state;

        emit logCreditStateChanged(state, block.timestamp);
    }

    function toggleActive() external onlyOwner returns (bool){
        active = !active;

        emit logCreditStateActiveChanged(active, block.timestamp);

        return active;
    }

    function invest() public canInvest payable {
        uint extraMoney = 0;

        if (address(this).balance >= requestedAmount){
            extraMoney = address(this).balance.sub(requestedAmount);
            
            // address(this).balance.sub(extraMoney)
            assert(requestedAmount == address(this).balance.sub(extraMoney));
            assert(extraMoney <= msg.value);

            // payable (msg.sender).transfer(extraMoney);
        }

        if (extraMoney > 0){
            payable(msg.sender).transfer(extraMoney);

            emit logLenderChangeReturned(msg.sender, extraMoney, block.timestamp);

            state = State.repayment;
            emit logCreditStateChanged(state, block.timestamp);
        }

        lenders[msg.sender] = true;
        lendersCount++;

        lendersInvestedAmount[msg.sender] = lendersInvestedAmount[msg.sender].add(msg.value.sub(extraMoney));

        emit logLenderInvestment(msg.sender, msg.value.sub(extraMoney), block.timestamp);

    }

    


}