pragma solidity ^0.8.13;

// delegatecall is low level function similar call
// A executes delegatecall to contract B, B's code is executed
// with contract A's storage, msg.sender and msg.value
contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num);
        )
    }
}