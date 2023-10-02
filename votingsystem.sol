//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 1. Ensure that all state variables are private

// 2. create a smart contract for the voting system

// 3. Implement a function for the contract owner to register new voters

// 4. Allow only the contract owner to add new voters

// 5. Create a modifier (e.g. onlyVoter) or a function to check that only registered voters can interact with the contract.
// apply this check to all voting-related functions

// 6. Develop functions for registered voters to cast their votes

// 7. Create a function to retrieve the current vote count

contract VotingSystem  {
  // define a struct to hold voters information

  struct Voter {

   uint256 voterId;
   address voteraddress;
   uint256 weight;
   uint256 vote; //index of the voted proposal
   bool registered; //true if voter is registered to vote
   bool voted; //true if voter has voted
  }
  
  // define a struct to hold the candidates information

  struct Candidate {
    uint256 candidateId;
    string candidateName;
    address candidateAddress;
    uint256 voteCount;
  }
    address[] public candidateAddress;

    address[] public candidateAddresses;
    mapping(address => Candidate) public candidates;

    address public chairperson; //the chairperson is the contract owner

   modifier onlyOwner {
       require(msg.sender == chairperson, "You are not the chairperson");
       _;
   }
        modifier onlyVoter{
       require(voters[msg.sender].registered, "You are not a voter");
       _;
   }

    mapping(address => Voter) public voters;
    //create a function that registers new voters and allows the chairperon/contract owner to register new voters

    function registervoter(address voter) public view {
        require(msg.sender == chairperson, "Only the chairperson can register voters");
        require(!voters[voter].voted, "voter has already voted");
        require(voters[voter].weight == 0);

        voters[voter].weight == 1; 
    }

    // functions for registered voters to cast their votes

    function vote(address _candidateAddress, uint256 _candidateId) public onlyVoter {
        Voter storage voter = voters[msg.sender];
        require(voter.weight != 0, "This voter has not been registered");
        require(!voter.voted, "This voter has already voted");
        
        voter.voted = true;
        voter.vote = _candidateId;
    
    //function to retrieve the current vote count

        candidates[_candidateAddress].voteCount += voter.weight;

    }




}
