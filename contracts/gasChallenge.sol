// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract gasChallenge {
    uint256[10] numbers = [1,2,3,4,5,6,7,8,9,10]; // Fixed-size array
    
    // Caching of state variables
    uint256 private sumOfArray;
    
    // Function to check for sum of array
    function getSumOfArray() public view returns (uint256) {
        return sumOfArray;
    }
    
    function calculateSumOfArray() private returns (uint256) { // Calculate sum and cache it
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        sumOfArray = sum;
        return sum;
    }
    
    function notOptimizedFunction() public {
        for (uint256 i = 0; i < numbers.length; i++) {
            numbers[i] = 0;
        }
    }
    
    function optimizedFunction() public {
        sumOfArray = 0; // Update the cached sum to 0
        
        assembly {
            let ptr := numbers.slot // Get the storage slot of the numbers array
            
            // Uncheck block optimization
            for { let i := 0 } lt(i, 10) { i := add(i, 1) } {
                sstore(add(ptr, mul(i, 0x20)), 0) // Store 0 directly in storage
            }
        }
    }
}
