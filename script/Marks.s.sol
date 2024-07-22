// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// forge script script/Marks.s.sol:HackScript --rpc-url $SEPOLIA_RPC_URL -vvvv --private-key $PRIVATE_KEY --legacy --broadcast

import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";

contract HackScript is Script {
        HackMeIfYouCan public toHack = HackMeIfYouCan(0x9D29D33d4329640e96cC259E141838EB3EB2f1d9);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // toHack.getMarks(0xF2D7D554489284F81ac3f7aEb9010fF92030a3A2);
        toHack.getMarks(0xbae642face0d4988f356a0fe2aebb077600ef0e1);
        vm.stopBroadcast();
    }
}
