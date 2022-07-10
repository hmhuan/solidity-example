pragma solidity ^0.8.13;
pragma experimental ABIEncoderV2;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/math/SafeMath.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";

contract BiDirectionalPaymentChannel {
    using SafeMath for uint;
    using ECDSA for bytes32;

    event ChallengeExit(address indexed sender, uint nonce);
    event Withdraw(address indexed to, uint amount);

    address payable[2] public users;
    mapping(address => bool) public isUser;

    mapping(address => uint) public balances;

    uint public challengePeriod;
    uint public expiredAt;
    uint public nonce;

    modifier checkBalance(uint[2] memory _balances) {
        require (
            address(this).balance >= _balances[0].add(_balances[1]),
            "balance of contract must be greater to or equal the total of balance of users"
        );
        _;
    }

    // Note: deposit from multi-sig wallet
    constructor(
        address payable[2] memory _users,
        uint[2] memory _balances,
        uint _expiredAt,
        uint _challengePeriod,
    ) payable checkBalances(_balances) {
        require(_expiredAt > block.timestamp, "Expiration must greater than now");
        require(_challengePeriod > 0, "Challenge period must be greater than 0");

        for (uint i=0; i < _users.length; i++) {
            address payable user = _users[i];

            require(!isUser[user], "user must be unique");
            users[i] = user;
            isUser[user] = true;

            balances[user] = _balances[i];
        }
        expiredAt = _expiredAt;
        challengePeriod = _challengePeriod;
    }

    function verify(
        bytes[2] memory _signatures,
        address _contract,
        address[2] memory _signers,
        uint[2] memory _balances,
        uint _nonce
    ) public pure returns (bool) {
        for (uint i=0; i<_signatures.length; i++) {
            /*
                Note: sign with address of this contract to protect 
                    agains replay attack on other contracts
            */
            bool valid = _signers[i] == keccak256(abi.encodePacked(_contract, _balances, _nonce))
                                        .toEthSignedMessageHash()
                                        .recover(_signatures[i]);

            if (!valid) {
                return false;
            }
        }

        return true;
    }

    modifier checkSignatures(
        bytes[2] memory _signatures,
        uint[2] memory _balances,
        uint _nonce
    ) {
        // copr storage array to memory
        address[2] memory signers;
        for (uint i=0; i<users.length; i++) {
            signers[i] = users[i];
        }

        require( 
            verify(_signatures, address(this), signers, _balances, _nonce),
            "Invalid signature"
        );
        _;
    }

    modifier onlyUser() {
        require(isUser[msg.sender], "Not user");
        _;
    }

    function challengeExit(
        uint[2] memory _balances,
        uint _nonce,
        bytes[2] memory _signatures
    ) 
        public onlyUser 
        checkSignatures(_signatures, _balances, _nonce)
        checkBalances(_balances) 
    {
        require(block.timestamp < expiredAt, "Expired challenge period");
        require(_nonce > nonce, "Nonce must be greater than the current nonce");

        for (uint i=0; i < _balances.length; i++) {
            balances[i] = _balances[i];
        }

        nonce = _nonce;
        expiredAt = block.timestamp.add(challengePeriod);

        emit ChallengeExit(msg.sender, nonce);
    }

    function withdraw() public onlyUser {
        require(block.timestamp >= expiredAt, "Chalenge period has not expired yet");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");

        emit Withdraw(msg.sender, amount);
    }
}