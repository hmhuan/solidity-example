pragma solidity ^0.8.13;

contract Account {
    uint public balance;
    uint public constant MAX_UINT = 2 ** 256 - 1;

    function deposit(uint _amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + _amount;

        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function widthdraw(uint _amount) public {
        uint oldBalance = balance;

        require(balance >= _amount, "Underflow");

        balance -= _amount;

        assert(balance <= oldBalance);
    }
}