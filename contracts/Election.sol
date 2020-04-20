pragma solidity >=0.4.21 <0.7.0;

contract Election {
    // Model a Campaign
    struct Campaign {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Campaign
    mapping(uint => Campaign) public campaigns;
    // Store Candidates Count
    uint public campaignsCount;

    // voted event
    event votedEvent (
        uint indexed campaignId
    );

    constructor() public {
        addCampaign("Campaign 1");
        addCampaign("Campaign 2");
    }

    function addCampaign (string memory name) private {
        campaignsCount ++;
        campaigns[campaignsCount] = Campaign(campaignsCount, name, 0);
    }

    function vote (uint campaignId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "Vote leaw");

        // require a valid candidate
        require(campaignId > 0 && campaignId <= campaignsCount, "Invalid candidate");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        campaigns[campaignId].voteCount ++;

        // trigger voted event
        emit votedEvent(campaignId);
    }
}