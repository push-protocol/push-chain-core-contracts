// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Test.sol";
import "../src/libraries/ChainIdFetcher.sol";


contract ChainIdFetcherTest is Test {
    function testGetChainId() public {
        // Test with EVM chain identifiers
        assertEq(ChainIdFetcher.getChainId("eip155:1"), 1);
        assertEq(ChainIdFetcher.getChainId("eip155:101"), 101);
        assertEq(ChainIdFetcher.getChainId("eip155:11155111"), 11155111);
        
        // Test with other chain identifiers
        assertEq(ChainIdFetcher.getChainId("solana:1000"), 1000);
        assertEq(ChainIdFetcher.getChainId("cosmos:42"), 42);
        assertEq(ChainIdFetcher.getChainId("polkadot:0"), 0);
        assertEq(ChainIdFetcher.getChainId("near:1313161554"), 1313161554);
        assertEq(ChainIdFetcher.getChainId("flow:9001"), 9001);
        
        // Test with invalid chain identifiers
        assertEq(ChainIdFetcher.getChainId("eip155:"), 0);
        assertEq(ChainIdFetcher.getChainId("eip155"), 0);
        assertEq(ChainIdFetcher.getChainId("eip155:abc"), 0);
        assertEq(ChainIdFetcher.getChainId(":123"), 0);
        assertEq(ChainIdFetcher.getChainId(""), 0);
    }
} 