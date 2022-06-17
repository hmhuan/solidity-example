pragma solidity ^0.8.13;

// can import from github
// import "https://github.com/owner/repo/blob/branch/path/to/Contract.sol";

// import foo from current project
import "./Foo.sol";

// import {symbol as alias} from "filename";
import {Unauthorized, add as funcAdd, Point} from "./Foo.sol";

contract Import {
    Foo public foo = new Foo();

    function getFooName() public view returns (string memory) {
        return foo.name();
    }
}