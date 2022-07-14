pragma solidity ^0.8.13;

contract ReEntrancyGuard {
    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No Re entrancy");
        locked = true;
        _;
        locked = false;
    }
}