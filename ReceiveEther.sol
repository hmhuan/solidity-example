pragma solidity ^0.8.13;

// Send Ether
// - transfer(<gas>, throws error)
// - send(<gas>, returns bool)
// - call(forward all gas or set gas, returns bool)

// Receive Ether
// a contract receiving Ether must have one of the functions below
// - receive() external payable
// - fallback() external payable
// receive is called if msg.data is empty otherwise fallback is called
contract ReceiveEther {
    receive() external payable {

    }

    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}