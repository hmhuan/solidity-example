pragma solidity ^0.8.13;

/*
some gas saving techniques:
    replacing memory with calldata
    loading state variable to memory
    replacing for loop i++ with ++i
    caching array elements
    short circuit
*/

contract GasGolf {
    uint public total;

    function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;

        for (uint i=0; i < len; ) {
            uint num = nums[i];
            if (num < 99 && num % 2 == 0) {
                _total += num;
            }

            unchecked { // checked is default - unchecked block to save gas
                ++i;
            }
        }
        total = _total;
    }
}