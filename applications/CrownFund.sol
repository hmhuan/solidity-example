pragma solidity ^0.8.13;

/*
    Crowd fund ERC20 token
    - User create a campaign
    - Usres can pledge, transferring their token to campaign
    - After campaign ends, campaign creator can claim the funds if total amount pledged is more than the campaign goal
    - otherwise campaign did not reach the goal users can withdraw their pledge
*/

interface IERC20 {
    function transfer(address, uint) external returns (bool);

    function transferFrom(
        address,
        address,
        uint
    ) external returns (bool);
}

contract CrownFund {
    event Launch(uint id, address indexed creator, uint goal, uint32 startAt, uint32 endAt);
    event Cancel(uint id);
    event Pledge(uint indexed id, address indexed caller, uint amount);
    event Unpledge(uint indexed id, address indexed caller, uint amount);
    event Claim(uint id);
    event Refund(uint id, address indexed caller, uint amount);

    struct Campaign {
        address creator;    // creator of campaign
        uint goal;          // amount of tokens to raise
        uint pledge;        // total amount pledge
        uint startAt;       // timestamp of start of campaign
        uint endAt;         // timestamp of end of campaign
        bool claimed;       // true if goal was reached and creator has claimed the tokens
    }

    IERC20 public immutable token;

    uint public count;
    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public pledgeAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function launch(uint _goal, uint32 _startAt, uint32 _endAt) external {
        require(_startAt >= block.timestamp, "start at lesss than now");
        require(_endAt >= _startAt, "end at is less than start at");
        require(_endAt <= block.timestamp + 90 days, "end at greater than max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledge: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp < campaign.startAt, "campaign started");

        delete campaigns[_id];
        emit Cancel(_id);
    }

    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledge += _amount;
        pledgeAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);

        emit Pledge(_id, msg.sender, _amount);
    }

    function unPledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledge -= _amount;
        pledgeAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);

        emit Unpledge(_id, msg.sender, _amount);
    }

    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(campaign.endAt < block.timestamp, "not ended");
        require(campaign.pledge >= campaign.goal, "pledge less than goal");
        require(!campaign.claimed, "claimed")

        campaign.claimed = true;
        token.transfer(campaign.creator, campaign.pledge);

        emit Claim(_id);
    }

    function refund(uintt _id) external {
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "nto ended");
        require(campaign.pledge < campaign.goal, "pledge is equal or greater than goal");

        uint balance = pledgeAmount[_id][msg.sender];
        pledgeAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, balance);

        emit Refund(_id, msg.sender, balance);
    }
}