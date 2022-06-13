pragma solidity ^0.8.13;

import "./TodoStruct.sol";

contract Todos {

    Todo[] public todos;

    function create(string calldata _text) public {
        todos.push(Todo(_text, false));

        // key value mapping
        // todos.push(Todo({text: _text, completed: false}));

        // initialize an empty struct and then update it
        // Todo memory todo;
        // todo.text = _text;
        // todos.push(todo);
    }

    // solodity automatically create a getter for todos.
    // don't need to create this function
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // toggle completed
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}