// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


library ChainIdFetcher {
    /**
     * @dev Extracts the chain ID from a CAIP-2 chain identifier string
     * @param chainIdentifier The chain identifier string (e.g., "eip155:1")
     * @return The extracted chain ID as a uint256
     */
    function getChainId(string memory chainIdentifier) internal pure returns (uint256) {
        bytes memory chainBytes = bytes(chainIdentifier);
        
        // Find the position of the colon
        uint256 colonPos = 0;
        for (uint256 i = 0; i < chainBytes.length; i++) {
            if (chainBytes[i] == bytes1(":")) {
                colonPos = i;
                break;
            }
        }
        
        // Return 0 if no colon found or if it's the last character
        if (colonPos == 0 || colonPos == chainBytes.length - 1) {
            return 0;
        }
        
        // Parse the number after the colon
        uint256 result = 0;
        for (uint256 j = colonPos + 1; j < chainBytes.length; j++) {
            uint8 digit = uint8(chainBytes[j]) - 48; // '0' is 48 in ASCII
            
            // Check if it's a valid digit
            if (digit > 9) {
                return 0; // Invalid character
            }
            
            result = result * 10 + digit;
        }
        
        return result;
    }
} 