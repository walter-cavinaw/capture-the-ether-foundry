# Capture The Ether Foundry (A [RareSkills](http://www.rareskills.io/) fork)
This project provides a foundry environment to practice the problems on [capturetheether.com/](https://capturetheether.com/). The problems run on a defunct testnet and use an older version of Solidity. This repository doesn't depend on testnets and uses the latest Solidity version. Some problems could not be ported because they rely on vulnerabilities that only existed in older versions of Solidity. Some liberty has been taken where the syntax and other compiler features are no longer compatible.

## How to play
Make sure foundry is installed. [instructions](https://book.getfoundry.sh/getting-started/installation)

cd to the directory of the problem, then add your solution in the test where the comment says `// Put your solution here`. We've also set up attacking contracts for you. If the tests pass, you were successful. Run the tests with `forge test` (exception for problem 8 below).

### 8PredictBlockhash:

run it with "forge test --fork-url https://1rpc.io/eth -vvvv"

## Want more problems?
Check out our [solidity riddles](https://github.com/rareSkills/solidity-riddles). It includes 20 CTFs and counting!


# Answers
- Guess the secret number: iterate over numbers in a view function and check the abi encoded number against answer hash.
- Guess the new number: Construct the answer int in the same way as the contract does it.
- Predict the future: Can only be 1 of 10 possible numbers. Also need to add receive function to contract.
- Token bank challenge: attacker contract has to own the tokens. When it withdraw it can call back into withdraw before the bank balance is updated.
- Predict blockhash: just wait for 256 blocks to pass and then blockhash goes back to zero.
- token whale: bug with transferFrom, where it reduces msg.sender in an unchecked block so you can transfer to the same account repeatedly.
