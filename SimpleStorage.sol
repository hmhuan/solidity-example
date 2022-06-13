pragma solidity ^0.8.13;

contract SimpleStorage {
    uint public num; // a state public varaible store a number
    
    // send a transaction to write to a state variable
    function set(uint _num) public {
        num = _num;
    }

    // read from state variable without sending a transaction
    function get() public views returns (uint) {
        return num;
    }
}