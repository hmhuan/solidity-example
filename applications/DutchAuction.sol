pragma solidity ^0.8.13;

/*
    seller of NFT deploys this contract setting a starting price for the NFT.
    auction lasts for 7 days
    price of NFT decreases over time
    participants can buy by depositing ETH greater than the current price computed by the smart contract.
    auction ends when a buyer buys the NFT
*/

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint _nftId
    ) external;
}

contract DutchAuction {
    uint private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiredAt;
    uint public immutable discountRate;

    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        startAt = block.timestamp;
        expiredAt = startAt + DURATION;
        discountRate = _discountRate;

        require(_startingPrice >= _discountRate * DURATION, "starting price is less than min");
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiredAt, "auction already expired");

        uint price = getPrice();
        require(msg.value >= price, "ETH < value");

        nft.transferFrom(seller, msg.sender, nftId);
        uint refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }

        selfdestruct(seller);
    }
}