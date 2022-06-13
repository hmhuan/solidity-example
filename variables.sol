pragma solidity ^0.8.13;

contract Variables {
    // state variables are stored on the blockchain
    string public text = "Hello";
    uint public num = 1234;

    function doSomething() public {
        // local variables are not stored on blockchain
        uint i = 456;

        // global variables
        uint timestamp = block.timestamp; // current block timestamp
        address sender = msg.sender; // address of the caller
    }
}