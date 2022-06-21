// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./interfaces/IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title L2 NFT minter contract
/// @notice For minting a tutorial NFT on L2 (StarkNet) through calling the L2 evaluator contract
contract MessagingNftMinter is Ownable {
    address public starknetAddress;
    uint256 public Ex2Selector;
    uint256 public EvaluatorAddress;

    /// @notice Admin function
    /// @dev Sets the L1 StarkNet proxy to point to
    /// @param _address L1 StarkNet proxy contract address
    function setStarknetAddress(address _address) external onlyOwner {
        starknetAddress = _address;
    }

    /// @notice Admin function
    /// @dev Sets the StarkNet contract function selector (for "ex2") to use
    /// @param _selector StarkNet contract function selector
    function setEx2Selector(uint256 _selector) external onlyOwner {
        Ex2Selector = _selector;
    }

    /// @notice Admin function
    /// @dev Sets the L2 evaluator contract to point to
    /// @param _address L2 evaluator contract address
    function setEvaluatorAddress(uint256 _address) external onlyOwner {
        EvaluatorAddress = _address;
    }

    /// @notice Mints tutorial NFT on L2
    /// @param l2_user StarkNet wallet address to receive NFT and tutorial credits
    function mintNftOnL2(uint256 l2_user) public {
        // Prepare payload to L2
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2_user;
        // Send the message to the L1 StarkNet proxy, hence L2
        IStarknetCore(starknetAddress).sendMessageToL2(
            EvaluatorAddress,
            Ex2Selector,
            payload
        );
    }
}
