pragma solidity ^0.8.13;


// Listening for event and updating user interface
// a cheap form of storage
contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello there");
        emit Log(msg.sender, "Hello again");
        emit AnotherLog();
    }
}