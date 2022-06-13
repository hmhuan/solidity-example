pragma solidity ^0.8.13;

import "./StatusEnum.sol";

contract Enum {
    // Default value is the first element listed in enum
    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function cancel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status; // reset status to its first value - PENDING
    }
}