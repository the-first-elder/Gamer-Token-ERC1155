// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Gamer} from "../src/Gamer.sol";
import {DeployGamer} from "../script/DeployGamer.s.sol";

contract GamerTest is Test {
    DeployGamer public deployGamer;
    address user = makeAddr("user");
    address user2 = makeAddr("user2");
    uint256 mintAmount = 1 ether;
    uint256 tokenId = 2;
    Gamer gamer;

    function setUp() public {
        deployGamer = new DeployGamer();
        (gamer) = deployGamer.run();
    }

    function testCanMintSoulBoundToken() public {
        vm.startPrank(user);
        gamer.mintSoulBound("0x");
        vm.stopPrank();
        assert(gamer.balanceOf(user, gamer.SOULBOUND()) == 1 ether);
    }

    function testMintFailsIfUSerOWnsSOulToken() public {
        vm.startPrank(user);
        // mint first round
        gamer.mintSoulBound("0x");
        vm.expectRevert(Gamer.Gamer__YouOwnAToken.selector);
        // mint second round
        gamer.mintSoulBound("0x");
        vm.stopPrank();
    }

    function testUSercannotSendOtherTokensWithoutHoldingSoulToken() public {
        vm.startPrank(user);
        vm.expectRevert(Gamer.Gamer__YouDontOwnAToken.selector);
        gamer.sendOtherTokens(user2, 3, mintAmount, "0x");
        vm.stopPrank();
    }

    // function testUserCanSendOtherTokensIfTheyHoldSoul() public {
    //     vm.startPrank(user);
    //     gamer.mintSoulBound("0x");
    //     gamer.mintOtherTokens(gamer.FIRE(), mintAmount, "0x");
    //     gamer.sendOtherTokens(user2, gamer.FIRE(), mintAmount, "0x");
    //     vm.stopPrank();
    //     assert(gamer.balanceOf(user2, gamer.FIRE()) == 1 ether);
    // }
}
