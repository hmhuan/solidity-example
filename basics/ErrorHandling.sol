pragma solidity ^0.8.13;

contract Error {
    function testRequire(uint _i) public pure {
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint _i) public pure {
        if (_i <= 10) {
            revert("Input must be greater then 10");
        }
    }

    uint public num;
    function testAssert() public view {
        assert(num == 0);
    }

    // custom Error
    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _widthdrawAmount) public view {
        uint bal = address(this).balance;
        if (bal < _widthdrawAmount) {
            revert InsufficientBalance({balance: bal, withdrawAmount: _widthdrawAmount})
        }
    }
}