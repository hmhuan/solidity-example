pragma solidity ^0.8.13;

// abi.encode -> data into bytes
// abi.decode -> bytes into data

contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(uint x, address addr, uint[] calldata arr, MyStruct calldata myStruct) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data) external pure returns (uint x, address addr, uint[] memory arr, MyStruct memory myStruct) {
        (x, addr, arr, myStruct) = abi.decode(data, (uint, address, uint[], MyStruct));
    }
}