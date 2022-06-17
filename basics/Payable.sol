pragma solidity ^0.8.13;

// functions and addresses declared payable can receive ether into the contract
contract Payable {
    // Payable address
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function deposit() public payable {

    }

    // call this function along with some ether
    // the function will throw an error since this function is not payable
    function notPayable() public {

    }

    // function to withdraw all Ether from this conttract
    function withdraw() public {
        uint amount = address(this).balance;

        // Send all Ether to owner
        // owner can receive ether b/c the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    function transfer(address payable _to, uint _amount) public {
        // _to is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether")
    }

}