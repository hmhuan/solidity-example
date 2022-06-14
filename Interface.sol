pragma solidity ^0.8.13;

contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }
}

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract MyContract {
    function incCounter(address _addr) external {
        ICounter(_addr).inc();
    }

    function getCount(address _addr) external view returns (uint) {
        return ICounter(_addr).count();
    }
}

