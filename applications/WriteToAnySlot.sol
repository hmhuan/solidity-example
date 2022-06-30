pragma solidity ^0.8.13;

// solidity storage is like an array of length 2 ^ 256. Each slot in the array can store 32 bytes
// state variables define which slots will be used to store data
// However using assembly, you can write to any slot

contract Storage {
    struct MyStruct {
        uint value;
    }

    MyStruct public s0 = MyStruct(123);
    MyStruct public s1 = MyStruct(456);
    MyStruct public s2 = MyStruct(789);

    function _get(uint i) internal pure returns (MyStruct storage s) {
        assembly {
            s.slot := i
        }
    }

    function get(uint i) external view returns (uint) {
        return _get(i).value;
    }

    // set(999, 888) -> save data in slot 999 which is normally unaccesble
    function set(uint i, uint x) external {
        _get(i).value = x;
    }
}