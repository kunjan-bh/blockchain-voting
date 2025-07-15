// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract voting {
    struct candidates {
        string name;
        uint candidateId;
        uint voteCount;
    }
    struct voter {
        string name;
        uint voterId;
        bool voted;
        uint votedTo;

    }
    struct donor{
        uint balance;
    }
    mapping(address=> voter) public voters;
    mapping(uint=> candidates) public Candidates;
    mapping(address=> donor) public Donors;

    enum votingStatus {NotStarted, OnGoing, Ended}
    votingStatus public voteStatus;
    address public owner;
    uint public candidatesCount;
    modifier onlyOwner() {
        require(msg.sender ==owner,"Only Owner");
        _;
    }

    modifier onlyDuringVoting() {
        require(voteStatus ==votingStatus.OnGoing,"Voting Not ongoing");
        _;
    }
    event NewVote(string name, uint voterId);
    event VotingStarted();
    event VotingEnded();
    event etherReceived(address add, uint value);
    event functionNnotFound();
    event refunded(address donorAddress, uint amount);

    constructor(string[] memory CandidatesName) {
        candidatesCount = 0;
        for(uint i=0; i<CandidatesName.length; i++){
            Candidates[i] = candidates( CandidatesName[i], i, 0);
            candidatesCount ++ ; 
        }

        owner=msg.sender;

        voteStatus = votingStatus.NotStarted;
        
    }

    function startVoting () public onlyOwner{
        require(voteStatus == votingStatus.NotStarted, "Voting has already started or ended!");
        voteStatus = votingStatus.OnGoing;
        emit VotingStarted();

    }
    function vote (string memory name, uint voterId, uint candidateId) public onlyDuringVoting{
        require(!voters[msg.sender].voted, "Already voted");
        require(candidateId<= candidatesCount,"Invalid candidate id!");
        Candidates[candidateId].voteCount++;
        voters[msg.sender]= voter(name, voterId, true, candidateId);
        emit NewVote(name, voterId);

    }
    function endVote() public {
        require (voteStatus == votingStatus.OnGoing,"Voting has not started or ended");
        voteStatus = votingStatus.Ended;
        emit VotingEnded();
    }
    function getCandidates(uint id) public view returns(string memory name, uint voteCount, uint candidateId){
        return (Candidates[id].name, Candidates[id].voteCount, Candidates[id].candidateId);
    }
//receive function for the donation in form of plain ether
    receive() external payable{
        Donors[msg.sender].balance += msg.value;
        emit etherReceived(msg.sender, msg.value);
    }

    function refundToDonor() external payable {
        require (Donors[msg.sender].balance>0, "No balance to transfer.");
        uint amount = Donors[msg.sender].balance;
        Donors[msg.sender].balance = 0;
        payable(msg.sender).transfer(amount);
        emit refunded(msg.sender, amount);
        
    }

    fallback() external {
        emit functionNnotFound();
    }

   
}