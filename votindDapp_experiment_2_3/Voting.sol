pragma solidity ^0.4.7;
//Voting Smart Contract, constructed in Solidity 
//The contract creates a module of a Candidate and assigns ID, Name and VoteCount variables
//The constructor creates four candidates automatically by using the method addCandidate
//main function for vote checks if a voter has voted before, if note accepts its choice and records the vote
//Check results function allows only the contract creator to look up for Election results

//voting class
contract Voting {

    //Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    //address of the owner of the contract (f.e. Government)
    address private owner;

    //Store candidates
    mapping ( uint => Candidate ) private candidates;

    //store the number of the candidates
    uint public candidatesCount;

    //store acc that voted
    mapping ( address => bool ) public voters; 

    //constructor (run when the contract is migrated)
    //public in order to be executed when the contract is deployed in the Blockchain
    function Voting ( ) public {

      //assignes the owner of the contract
      owner = msg . sender;

      addCandidate ( "J.F.Kennedy" );
      addCandidate (  "G.W.Bush" );
      addCandidate ( "B.Obama" );
      addCandidate ( "D.Trump" );
    }

    //Add Candidate, private because only the contract have to be able to access it
    function addCandidate ( string _name ) private {

        candidatesCount++;
        candidates [ candidatesCount ] = Candidate ( candidatesCount, _name, 0 );
    }
	
	//Function to vote, if not voted before, if valid candidate
    function vote ( uint _candidateId ) public {

        //havent voted before
        require ( !voters [ msg.sender ] );

        //vote for valid candidate
        require ( _candidateId > 0 && _candidateId <= candidatesCount );

        //record voter has voted
        voters[ msg.sender ] = true;

        //update candidate vote Count
        candidates [ _candidateId ] . voteCount ++;

    }
	//Displays Election results, only if contact creator is calling it
    function showResults (uint i )  view public returns ( string, uint ) {

        if ( msg . sender == owner ) {

            string storage candiateName = ( candidates [ i ] . name);

            uint votes = ( candidates [ i ] . voteCount );

            return (candiateName, votes);
        }

    }

}
