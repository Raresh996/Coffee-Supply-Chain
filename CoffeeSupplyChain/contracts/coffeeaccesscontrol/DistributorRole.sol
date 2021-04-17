pragma solidity ^0.5.16;

import "./Roles.sol";

contract DistributorRole {
    using Roles for Roles.Role;

    event DistributorAdded(address indexed account);
    event DistributorRemoved(address indexed account);

    Roles.Role distributors;

    constructor() public {
        _addDistributor(msg.sender);
    }

    modifier onlyDistributor() {
        require(
            isDistributor(msg.sender),
            "Only distributors can call this function"
        );
        _;
    }

    function isDistributor(address account) public view returns (bool) {
        return distributors.has(account);
    }

    function addDistributor(address account) public onlyDistributor {
        distributors.add(account);
    }

    function renounceDistributor() public {
        _removeDistributor(msg.sender);
    }

    function _addDistributor(address account) internal {
        distributors.add(account);
        emit DistributorAdded(account);
    }

    function _removeDistributor(address account) internal {
        distributors.remove(account);
        emit DistributorRemoved(account);
    }
}
