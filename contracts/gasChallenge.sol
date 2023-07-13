// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract gasChallenge {
    uint[10] numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    
    // Function to get the sum of all elements in the array
    function getSumOfArray() public view returns (uint256) {
        uint sum = 0;   
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
    
    // Function that sets all elements of the array to zero
    function notOptimizedFunction() public {
        for (uint i = 0; i < numbers.length; i++) {
            numbers[i] = 0;
        }
    }
    
    // Optimized function to set all elements of the array to zero
   function optimizedFunction() public {
    // Cache the length of the array to avoid repeated state variable access
    uint length = numbers.length;
    
    // Use unchecked block to skip bounds checking
    unchecked {
        // Use different for loop increment syntax for gas optimization
        for (uint i = 0; i < length; i += 1) {
            numbers[i] = 0;
        }
    }
}

}
