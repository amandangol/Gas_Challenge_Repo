const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Deploy Gas Challenge Contract", () => {
  let gas_contract;

  beforeEach(async () => {
    const gas_challenge_contract = await ethers.getContractFactory("gasChallenge");
    gas_contract = await gas_challenge_contract.deploy();
    await gas_contract.deployed();
  });

  describe("Compute Gas", () => {
    it("Should return lower gas", async () => {
      const notOptimizedTx = await gas_contract.notOptimizedFunction();
      const optimizedTx = await gas_contract.optimizedFunction();

      const notOptimizedReceipt = await notOptimizedTx.wait();
      const optimizedReceipt = await optimizedTx.wait();

      console.log("Not Optimized Gas Used:", notOptimizedReceipt.gasUsed.toString());
      console.log("Optimized Gas Used:", optimizedReceipt.gasUsed.toString());

      expect(optimizedReceipt.gasUsed).to.be.lessThan(notOptimizedReceipt.gasUsed);
    });
  });

  describe("Check Sum Of Array", () => {
    it("Should return 0", async () => {
      await gas_contract.optimizedFunction();
  
      const sum = await gas_contract.getSumOfArray();
      const numbers = await gas_contract.numbers;
  
      console.log("Array Elements:", numbers);
      console.log("Sum:", sum.toString());
  
      expect(sum).to.equal(0);
    });
  });
});
