pragma solidity ^0.8.13;

// keyword: is 
// virtual
// override

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// multiple inherit 
// right most
contract D is B, C {
    function foo() public pure virtual override(B, C) returns (string memory) {
        return super.foo(); // "C"
    }
}

contract E is C, B {
    function foo() public pure virtual override(C, B) returns (string memory) {
        return super.foo(); // "B"
    }
}


// inheritance must be odered from "most base-like" to "most derived"

// Shadow inherited state variables
contract F {
    string public name = "Contract F";

    function getName() public view returns (string memory) {
        return name;
    }
}

// state variables cannot be overrided by re-declaring in its child contract
// the correct way is using constructor
contract G is F {
    constructor() {
        name = "Contract G";
    }
}