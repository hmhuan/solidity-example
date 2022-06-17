pragma solidity ^0.8.3;

contract Counter {
  uint count;
  function get() public view returns (uint) {
    return count;
  }
  
  function inc() public {
    count += 1;
  }
  
  function dec() public {
    // This function will fail if count = 0
    count -= 1;
  }
}
