pragma solidity ^0.8.13;

contract Function {
    function returnMany() public pure returns (
        uint,
        bool,
        uint
    ) {
        return (1, true, 24);
    }

    // returned values can be named
    function named() public pure returns (
        uint x,
        bool b,
        uint y
    ) {
        return (1, false, 24);
    }

    // returned values can be assigned
    function assigned() public pure returns (
        uint x,
        bool b,
        uint y
    ) {
        x = 1;
        y = 24;
        b = true;
    }

    function desructuringAssignments() public pure returns (
        uint,
        bool,
        uint,
        uint,
        uint
    ) {
        (uint i, bool b, uint j) = returnMany();

        // values can be left out
        (uint x, , uint z) = (1, 2, 3);

        return (i, b, j, x, z);
    }

    // cannot use mapping as input or output

    // can use array as input or output
    function arrayInput(uint[] memory _arr) public {

    }

    // create a local array
    uint[] public arr;

    function arrayOutput() public view returns (uint[] memory) {
        return arr;
    }
}