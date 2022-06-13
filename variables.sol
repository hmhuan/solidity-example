pragma solidity ^0.8.13;


// local: 
//   declare inside a function
//   not stored on the blockchain
// state:
//   declared outside function (in contract)
//   stored on the blockchain
// global: provides information about the blockchain  
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

    // constant cannot be modified
    // their value is hardcoded and using constant can save gas cost
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_INT = 1234;
}