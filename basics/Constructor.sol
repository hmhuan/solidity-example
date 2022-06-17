pragma solidity ^0.8.13;

contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 2 ways to initialize 

contract A is X("X"), Y("This is Y") {

}

contract B is X, Y {
    constructor(string memory _name, string memory _text) X(_name), Y(_text) {}
}

// order constructor call is based on order inheritance