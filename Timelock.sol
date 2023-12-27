{{
  "language": "Solidity",
  "sources": {
    "contracts/Timelock.sol": {
      "content": "/*\n  Timelock.sol \n  - This contract safeguards its assets through a timelock\n  - To withdraw assets, the contract owner must initiate the unlock\n  - The unlock period amounts to 1 week after the unlock is initiated\n  - After this week, the contract owner can withdraw assets at their discretion \n*/\n\n// SPDX-License-Identifier: UNLICENSED\npragma solidity ^0.8.9;\n\ninterface IERC20 {\n\n    function transfer(address recipient, uint amount) external returns (bool);\n\n}\n\ncontract Timelock {\n\n    address public constant owner = 0x60713fb108E323D83b1fbd7B3C95984f6F5eCD02;\n    uint256 public oneWeek = 60 * 15; // 15 min\n    uint256 public unlockTime;\n\n    /*\n      @require Requires the unlock time have not been set and msg.sender to be equal to contract owner\n    */\n    function unlock() public {\n\n        require(msg.sender == owner);\n        require(unlockTime == 0);\n        unlockTime = block.timestamp + oneWeek;\n\n    }\n\n    /*\n      @require Requires the unlock time to have passed, unlock time to be set, and msg.sender to be equal to contract owner\n      @param token The ERC20 token contract being transfered out of the contract\n      @param amount The amount of said ERC20 token\n    */\n    function withdraw(address token, uint256 amount) public {\n\n        require(msg.sender == owner);\n        require(unlockTime != 0);\n        require(unlockTime <= block.timestamp);\n        \n        IERC20(token).transfer(msg.sender, amount);\n\n    }\n\n}\n"
    }
  },
  "settings": {
    "optimizer": {
      "enabled": false,
      "runs": 200
    },
    "outputSelection": {
      "*": {
        "*": [
          "evm.bytecode",
          "evm.deployedBytecode",
          "devdoc",
          "userdoc",
          "metadata",
          "abi"
        ]
      }
    },
    "libraries": {}
  }
}}