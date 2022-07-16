## Re-Entrancy
EtherStore is a contract where you can deposit and withdraw ETH.
This contract is vulnerable to re-entrancy attack.
Let's see why.

    1. Deploy EtherStore
    2. Deposit 1 Ether each from Account 1 (Alice) and Account 2 (Bob) into EtherStore
    3. Deploy Attack with address of EtherStore
    4. Call Attack.attack sending 1 ether (using Account 3 (Eve)).
   You will get 3 Ethers back (2 Ether stolen from Alice and Bob,
   plus 1 Ether sent from this contract).

What happened?
Attack was able to call EtherStore.withdraw multiple times before
EtherStore.withdraw finished executing.

Here is how the functions were called

    - Attack.attack
    - EtherStore.deposit
    - EtherStore.withdraw
    - Attack fallback (receives 1 Ether)
    - EtherStore.withdraw
    - Attack.fallback (receives 1 Ether)
    - EtherStore.withdraw
    - Attack fallback (receives 1 Ether)

## Overflow

Vulnerability
    
    Solidity < 0.8
    Integers in Solidity overflow / underflow without any errors

    Solidity >= 0.8
    Default behaviour of Solidity 0.8 for overflow / underflow is to throw an error.



Preventative Techniques

    Use SafeMath to will prevent arithmetic overflow and underflow

    Solidity 0.8 defaults to throwing an error for overflow / underflow