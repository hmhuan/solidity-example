pragma solidity ^0.8.13;

// Mpping are not iterable

contract Mapping {
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        return myMap[_addr];
    }

    function set(address _addr, uint _value) public {
        myMap[_addr] = _value;
    }

    function remove(address _addr) public { 
        delete myMap[_addr];
    }
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) public nestedMap;

    function get(address _addr, uint _id) public view returns (bool) {
        return nestedMap[_addr][_id];
    }

    function set(address _addr, uint _id, bool _b) public {
        nestedMap[_addr][_id] = _b;
    }

    function remove(address _addr, uint _id) public {
        delete nestedMap[_addr][_id];
    }
}