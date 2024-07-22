// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import {console} from "forge-std/Test.sol";
import "forge-std/Script.sol";
import "../src/Hacker.sol";
// source .env
// forge script script/Deployer.s.sol:Deployer --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv --legacy --private-key $PRIVATE_KEY

contract Deployer is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Hacker hacker = new Hacker(0x9D29D33d4329640e96cC259E141838EB3EB2f1d9);
        console.log("Hacker address:", address(hacker));

        vm.stopBroadcast();
    }
}

