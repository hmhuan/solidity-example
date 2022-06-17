pragma solidity ^0.8.13;

// the wallet owners can
// - submit a transaction
// - approve and revoke approval of pending transactions
// - anyone can execute a transaction after enough owners has approved it
contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    )
    event ConfirmTransaction(address indexed owner, uint indexed txIndex);
    event RevokeConfirmation(address indexed owner, uint indexed txIndex);
    event ExecuteTransaction(address indexed owner, uint indexed txIndex);

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public numConfirmationsRequired;

    struct Transaction {
        address to,
        uint value,
        bytes data,
        bool executed,
        uint numConfirmations
    }

    mapping(uint => mapping(address => bool)) public isConfirmed;

    Transaction[] public transactions;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not owner");
        _;
    }

    modifier txExists(uint _txIndex) {
        require(_txIndex < transactions.length, "tx is not exists");
        _;
    }

    modifier notExecuted(uint _txIndex) {
        require(!transactions[_txIndex].executed, "tx already executed");
        _;
    }

    modifier notConfirmed(uint _txIndex) {
        require(!isConfirmed[_txIndex][msg.sender], "tx already confirmed");
        _;
    }

    constructor(address[] memory _owners, uint _numConfirmationsRequired) {
        require(_owner.length > 0, "list owner empty");
        require(
            _numConfirmationsRequired > 0 &&
            _numConfirmationsRequired <= _owner.length,
            "invalid number of required confirmations"
        );

        for (uint i=0; i< _owner.length; ++i) {
            address owner = _owner[i];

            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        numConfirmationsRequired = _numConfirmationsRequired;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) public onlyOwner {
        uint txIndex = transaction.length;
        
        transactions.push(
            Transaction({
                to: _to,
                value: _value,
                data: _data,
                executed: false,
                numConfirmations: 0
            })
        );

        emit SubmitTransaction(msg.sender, txIndex, _to, _value, _data);
    }

    function confirmTransaction(uint _txIndex) 
        public 
        onlyOwner 
        txExists(_txIndex) 
        notExecuted(_txIndex)
        notConfirmed(_txIndex) 
    {
            Transaction storage tx = transactions[_txIndex];
            tx.numConfirmations += 1;
            isConfirmed[_txIndex][msg.sender] = true;

            emit ConfirmTransaction(msg.sender, _txIndex);
    }

    function executeTransaction(uint _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex) 
    {
        Transaction storage tx = transactions[_txIndex];
        require (
            tx.numConfirmations >= numConfirmationsRequired,
            "cannot executed, need more confirmation"
        );
        tx.executed = true;

        (bool success, ) = tx.to.call{value: tx.value}(tx.data);

        require(success, "execute tx failed");

        emit ExecuteTransaction(msg.sender, _txIndex);
    }

    function revokeTransaction(uint _txIndex)
        public
        isOwner
        txExists(_txIndex)
        notExecuted(_txIndex)
    {
        Transaction storage tx = transactions[_txIndex];
        
        require(isConfirmed[_txIndex][msg.sender], "tx is not confirmed");

        tx.numConfirmations -= 1;
        isConfirmed[_txIndex][msg.sender] = false;

        emit RevokeConfirmation(msg.sender, _txIndex);
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function getTransactionCount() public view returns (uint) {
        return transactions.length;
    }

    function getTransaction(uint _txIndex) public view txExists(_txIndex) 
        returns (
            address to, 
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )
    {
        Transaction tx = transactions[_txIndex];

        return (
            tx.to,
            tx.value,
            tx.data,
            tx.executed,
            tx.numConfirmations
        )
    }
}