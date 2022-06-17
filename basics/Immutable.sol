pragma solidity ^0.8.13;

// Immutable variables are like constant although they can be set inside the constructor and cannot be. modified afterwards.

contract Immutable {
    address public immutable MY_ADDRESS_IM;
    uint public immutable MY_INT_IM;

    constructor(uint _myUint) {
        MY_ADDRESS_IM = msg.sender;
        MY_INT_IM = _myUint;
    }
}