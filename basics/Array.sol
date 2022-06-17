pragma solidity ^0.8.13;

contract Array {
    uint[] public arr;
    uint[] public arr1 = [1, 2, 3];

    // fixed size Array
    uint[10] public arr2;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // avoid to return array that can grow indefinitely in length
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        arr.push(i);
    }

    function pop() public {
        // remove last element from array
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // delete element not change array 
        // the value of that element will be reseted the default value
        delete arr[index];
    }

    function example() external {
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
    }
}

contract ArrayRemoveByShifting {
    uint[] public arr;

    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");

        for (uint i = _index; i < arr.length; i++) {
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1,2,3,4,5,6];
        remove(2); // [1,2,4,5,6]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr[4] == 6);

        arr = [1];
        remove(0);
        assert(arr.length == 0);
    }
}