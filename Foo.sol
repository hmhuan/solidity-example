pragma solidity ^0.8.13;

struct Point {
    uint x;
    uint y;
}

error Unauthorized(address caller);

function add(uint x, uint y) public pure returns (uint) {
    return x + y;
}

contract Foo {
    string public name = "Foo";
}