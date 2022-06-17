pragma solidity ^0.8.13;

// Send Ether
// - transfer(<gas>, throws error)
// - send(<gas>, returns bool)
// - call(forward all gas or set gas, returns bool)

// Receive Ether
// - receive() external payable
// - fallback() external payable
// receive is called if msg.data is empty otherwise fallback is called
contract ReceiveEther {

}