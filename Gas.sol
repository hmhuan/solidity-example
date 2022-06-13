pragma solidity ^0.8.13;

contract Gas {
    uint public i = 0;

    function forever() public {
        // we run a loop until all of the gas ar spent
        // and the transaction fails
        while (true) {
            i += 1
        }
    }
}