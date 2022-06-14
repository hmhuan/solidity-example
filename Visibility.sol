pragma solidity ^0.8.13;

/*
    public - any contract and account can call
    private - only inside the contract that defines the function
    internal- only inside contract that inherits an internal function
    external - only other contracts and accounts can call
*/

contract Base {
    function privateFunc() private pure returns (string memory) {
        return "private function";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    function internalFunc() internal pure returns (string memory) {
        return "internal function";
    }

    function testInternalFunc() public pure returns (string memory) {
        return internalFunc();
    }

    function publicFunc() public pure returns (string memory) {
        return "public function";
    }

    // other contracts and accounts
    function externalFunc() external pure returns (string memory) {
        return "external function";
    }

    // State variables
    string private privateStr = "private variable";
    string internal internalStr = "internal variable";
    string public publicStr = "public variable";
    // state not be external
}

contract Child is Base {
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}