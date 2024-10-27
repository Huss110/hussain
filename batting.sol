// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract BettingContract {
    enum State { Open, Closed, Resolved }
    enum Team { TeamA, TeamB }
    State public currentState;
    address public owner;
    Team public winningTeam;
    mapping(address => Bet) public bets;

    struct Bet { uint amount; Team team; }

    event BetPlaced(address indexed user, uint amount, Team team);
    event BetResolved(Team winningTeam);

    modifier onlyOwner() { require(msg.sender == owner, "Not owner"); _; }

    constructor() { owner = msg.sender; currentState = State.Open; }

    function placeBet(Team _team) external payable {
        require(currentState == State.Open, "Betting closed");
        bets[msg.sender] = Bet(msg.value, _team);
        emit BetPlaced(msg.sender, msg.value, _team);
    }

    function resolveBet(Team _winningTeam) external onlyOwner {
        currentState = State.Resolved; 
        winningTeam = _winningTeam;
        emit BetResolved(_winningTeam);
    }

    function withdraw() external {
        require(currentState == State.Resolved, "Not resolved");
        Bet memory bet = bets[msg.sender];
        require(bet.team == winningTeam, "Not winner");
        payable(msg.sender).transfer(bet.amount * 2);
    }
}
