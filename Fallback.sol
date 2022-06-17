pragma solidity ^0.8.13;

// fallback is a function that does not take any arguments and does not return anything 
// execute when:
// - a function does not exist is called
// - Ether is sent directly to a contract but receive() does not exist or msg.data is not empty

contract Fallback {
    event Log(uint gas);

    fallback() external payable {
        emit Log(gasLeft());
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}