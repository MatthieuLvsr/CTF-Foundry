// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import {Test, console} from "forge-std/Test.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";

contract HackMeIfYouCanTest is Test {
    HackMeIfYouCan public toHack;

    function setUp() public {
        bytes32[15] data;
        for(uint i = 0; i < 15; i++){
            data[i] = i;
        }
        bytes32 password = 515;
        toHack = new HackMeIfYouCan(password,data);
    }
}
