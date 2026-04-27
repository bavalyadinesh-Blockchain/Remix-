// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    // ENUM
    enum VotingStatus { NotStarted, Started, Ended }
    VotingStatus public status;

    // ADMIN
    address  owner;

    constructor() {
        owner = msg.sender;
        status = VotingStatus.NotStarted;
    }

    // STRUCT
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // STORAGE
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    uint public candidateCount;

    // EVENTS
    event CandidateAdded(uint id, string name);
    event Voted(address voter, uint candidateId);

    // MODIFIER
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier votingActive() {
        require(status == VotingStatus.Started, "Voting not active");
        _;
    }

    // ADD CANDIDATE
    function addCandidate(string memory _name) public onlyOwner {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0);

        emit CandidateAdded(candidateCount, _name);
    }

    // START VOTING
    function startVoting() public onlyOwner {
        status = VotingStatus.Started;
    }

    // END VOTING
    function endVoting() public onlyOwner {
        status = VotingStatus.Ended;
    }

    // VOTE FUNCTION
    function vote(uint _candidateId) public votingActive {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit Voted(msg.sender, _candidateId);
    }

    // GET WINNER
    function getWinner() public view returns (string memory winnerName) {
        require(status == VotingStatus.Ended, "Voting not ended");

        uint maxVotes = 0;
        uint winnerId = 0;

        for (uint i = 1; i <= candidateCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerId = i;
            }
        }

        return candidates[winnerId].name;
    }
}