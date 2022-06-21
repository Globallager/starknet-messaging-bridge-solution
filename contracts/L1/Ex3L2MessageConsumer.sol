// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./interfaces/IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title L2 message consumer
/// @notice For consuming L2 -> L1 messages in the L1 StarkNet proxy
contract MessageConsumer is Ownable {
    address public starknetAddress;

    /// @notice Admin function
    /// @dev Sets the L1 StarkNet proxy to point to
    /// @param _address L1 StarkNet proxy contract address
    function setStarknetAddress(address _address) external onlyOwner {
        starknetAddress = _address;
    }

    /// @notice Consumes a message in the L1 StarkNet proxy
    /// @param l2ContractAddress Address of the L2 contract that sent the message
    /// @param l2User StarkNet wallet address to receive tutorial credits
    function consumeMessage(uint256 l2ContractAddress, uint256 l2User)
        external
    {
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2User;
        // This L1 transaction would revert if the message does not exist
        IStarknetCore(starknetAddress).consumeMessageFromL2(
            l2ContractAddress,
            payload
        );
    }
}
