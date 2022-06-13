pragma solidity ^0.8.13;
// storage: variable is a state variable (store on blockchain)
// memory: variable is in memory and exists while a function being called
// calldata: special data location that contains function arguements

contract DataLocations {
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;

    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // get a struct from. mapping
        MyStruct storage s = myStructs[1];

        // create a struct in memory
        MyStruct memory s1 = MyStruct(0);
    }

    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do somethinf with storage variables
    }

    function g(unit[] memory _arr) public returns (unit[] memory) {

    }

    function h(uint[] calldata _arr) external {
        // do something with calldata array
    }
}