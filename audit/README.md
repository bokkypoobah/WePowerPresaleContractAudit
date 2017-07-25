# WePower Network Presale Contract Audit

This is an audit of [WePower Network's crowdsale](https://wepower.network/) PreSale contracts.

Commit [https://github.com/WePowerNetwork/wepower-contracts/commit/f93672427192402fb0eff20cd355db5cf981fa02](https://github.com/WePowerNetwork/wepower-contracts/commit/f93672427192402fb0eff20cd355db5cf981fa02).

No potential vulnerabilities have been identified in the crowdsale and token contract.

<br />

<hr />

## Table Of Contents

* [Recommendations](#recommendations)
* [Potential Vulnerabilities](#potential-vulnerabilities)
* [Scope](#scope)
* [Limitations](#limitations)
* [Due Diligence](#due-diligence)
* [Risks](#risks)
* [Trustlessness Of The Crowdsale Contract](#trustlessness-of-the-crowdsale-contract)
* [Notes](#notes)
* [Testing](#testing)
* [Crowdsale And Token Contracts Overview](#crowdsale-and-token-contracts-overview)
* [Code Review](#code-review)
* [References](#references)

<br />

<hr />

## Recommendations

* **IMPORTANT** There is the ability for the token contract owner to burn another user's tokens AFTER the PreSale is finalised

  In my testing results [test/test1results.txt](test/test1results.txt), the contract owner burnt an account's tokens after the PreSale was finalised:

       # Account                                             EtherBalanceChange                          Token Name
      -- ------------------------------------------ --------------------------- ------------------------------ ---------------------------
       0 0xa00af22d07c87d96eeeb0ed583f8f6ac7812827e      275.164275902000000000           0.000000000000000000 Account #0 - Miner
       1 0xa11aae29840fbb5c86e6fd4cf809eba183aef433       -0.144887526000000000           0.000000000000000000 Account #1 - Contract Owner
       2 0xa22ab8a9d641ce77e06d98b7d7065d324d3d6976      101.000000000000000000           0.000000000000000000 Account #2 - Multisig
       3 0xa33a6c312d9ad0e0f2e95541beed0cc081621fd0      -91.009323802000000000          90.940000000000000000 Account #3
       4 0xa44a08d3f6933c69212114bb66e2df1813651844      -10.006707466000000000           9.999998000000000000 Account #4
       5 0xa55a151eb00fded1634d27d1127b4be4627079ea       -0.003357108000000000           0.000000000000000000 Account #5
       6 0xa66a85ede0cbe03694aa9d9de0bb19c99ff55bd9        0.000000000000000000           0.000002000000000000 Account #6
       7 0xa77a2b9d4b1c010a22a7c565dc418cef683dbcec        0.000000000000000000           0.000000000000000000 Account #7
       8 0xa88a05d2b88283ce84c8325760b72a64591279a2        0.000000000000000000           0.060000000000000000 Account #8
       9 0xa99a0ae3354c06b1459fd441a32a3f71005d7da0        0.000000000000000000           0.000000000000000000 Account #9
      10 0x8970bbfd1a54ae581064ab34e7910dab7e86172f        0.000000000000000000           0.000000000000000000 MiniMeTokenFactory
      11 0x6b8bba219f069b3dd5920e6d6958071eb9b8bc50        0.000000000000000000           0.000000000000000000 Token 'WCT' 'WePower Contribution Token'
      12 0x2484679c29325eaf2f2e91d661e5413d47c04660        0.000000000000000000           0.000000000000000000 PreSale
      -- ------------------------------------------ --------------------------- ------------------------------ ---------------------------
                                                                                        101.000000000000000000 Total Token Balances
      -- ------------------------------------------ --------------------------- ------------------------------ ---------------------------
      ...
      crowdsale.finalizedBlock=929
      ...
      Owner Can Burn Tokens
      canBurnTx gas=200000 gasUsed=80383 costETH=0.001446894 costUSD=0.297267266088 @ ETH/USD=205.452 gasPrice=18000000000 block=951 txId=0xf206297b18bc5b1d39cdef71fc0ca5739fdf1fcb07896a6fc18fa0064b8e6703
       # Account                                             EtherBalanceChange                          Token Name
      -- ------------------------------------------ --------------------------- ------------------------------ ---------------------------
       0 0xa00af22d07c87d96eeeb0ed583f8f6ac7812827e      290.165722796000000000           0.000000000000000000 Account #0 - Miner
       1 0xa11aae29840fbb5c86e6fd4cf809eba183aef433       -0.146334420000000000           0.000000000000000000 Account #1 - Contract Owner
       2 0xa22ab8a9d641ce77e06d98b7d7065d324d3d6976      101.000000000000000000           0.000000000000000000 Account #2 - Multisig
       3 0xa33a6c312d9ad0e0f2e95541beed0cc081621fd0      -91.009323802000000000          89.939999999999999999 Account #3
       4 0xa44a08d3f6933c69212114bb66e2df1813651844      -10.006707466000000000           9.999998000000000000 Account #4
       5 0xa55a151eb00fded1634d27d1127b4be4627079ea       -0.003357108000000000           0.000000000000000000 Account #5
       6 0xa66a85ede0cbe03694aa9d9de0bb19c99ff55bd9        0.000000000000000000           0.000002000000000000 Account #6
       7 0xa77a2b9d4b1c010a22a7c565dc418cef683dbcec        0.000000000000000000           0.000000000000000000 Account #7
       8 0xa88a05d2b88283ce84c8325760b72a64591279a2        0.000000000000000000           0.060000000000000000 Account #8
       9 0xa99a0ae3354c06b1459fd441a32a3f71005d7da0        0.000000000000000000           0.000000000000000000 Account #9
      10 0x8970bbfd1a54ae581064ab34e7910dab7e86172f        0.000000000000000000           0.000000000000000000 MiniMeTokenFactory
      11 0x6b8bba219f069b3dd5920e6d6958071eb9b8bc50        0.000000000000000000           0.000000000000000000 Token 'WCT' 'WePower Contribution Token'
      12 0x2484679c29325eaf2f2e91d661e5413d47c04660        0.000000000000000000           0.000000000000000000 PreSale
      -- ------------------------------------------ --------------------------- ------------------------------ ---------------------------
                                                                                         99.999999999999999999 Total Token Balances
      -- ------------------------------------------ --------------------------- ------------------------------ ---------------------------

      PASS Owner Can Burn Tokens
      Transfer 0 #951: _from=0xa33a6c312d9ad0e0f2e95541beed0cc081621fd0 _to=0x0000000000000000000000000000000000000000 _amount=1.000000000000000001

  * [ ] ACTION Review whether the token contract owner should have the ability to burn another user's tokens after the PreSale is finalised

* **IMPORTANT** The contract owner can also generate any number of tokens after the PreSale is finalised

  * [ ] ACTION Review whether the token contract owner should have the ability to generate tokens after the PreSale is finalised

<br />

<hr />

## Potential Vulnerabilities

No potential vulnerabilities have been identified in the crowdsale and token contract.

<br />

<hr />

## Scope

This audit is into the technical aspects of the crowdsale contracts. The primary aim of this audit is to ensure that funds contributed to
these contracts is not easily attacked or stolen by third parties. The secondary aim of this audit is that ensure the coded algorithms work
as expected. This audit does not guarantee that that the code is bugfree, but intends to highlight any areas of weaknesses.

<br />

<hr />

## Limitations

This audit makes no statements or warranties about the viability of the WePower Network's business proposition, the individuals involved in
this business or the regulatory regime for the business model.

<br />

<hr />

## Due Diligence

As always, potential participants in any crowdsale are encouraged to perform their due diligence on the business proposition before funding
any crowdsales.

Potential participants are also encouraged to only send their funds to the official crowdsale Ethereum address, published on the
crowdsale beneficiary's official communication channel.

Scammers have been publishing phishing address in the forums, twitter and other communication channels, and some go as far as duplicating
crowdsale websites. Potential participants should NOT just click on any links received through these messages. Scammers have also hacked
the crowdsale website to replace the crowdsale contract address with their scam address.
 
Potential participants should also confirm that the verified source code on EtherScan.io for the published crowdsale address matches the
audited source code, and that the deployment parameters are correctly set, including the constant parameters.

<br />

<hr />

## Risks

* The risk of funds getting stolen or hacked from the *PreSale* contract is low as contributed funds are moved directly to an external 
  multisig, hardware or regular wallet.

* This set of contracts have some complexity in the linkages between the separate *WCT* (*MiniMeToken*) and *PreSale* contract. The set up
  of the contracts will need to be carefully verified after deployment to confirm that the contracts have been linked correctly.

<br />

<hr />

## Trustlessness Of The Crowdsale Contract

* The *WCT* (*MiniMeToken*) contract `controller` has the ability to burn any accounts token balances using `destroyTokens(...)`, or to
  disable and enable any transfers using `enableTransfers(...)`. For this contract to be trustless, the *WCT* contract `controller` will
  need to be set an account that no one controls like `0x0000000000000000000000000000000000000000`. Setting this `controller` to this
  "burn" address may prevent the owner executing some operations in the future.

  * [ ] ACTION Review whether the token contract owner should have the ability to burn another user's tokens after the PreSale is finalised

* The contract owner can also generate any number of tokens after the PreSale is finalised

  * [ ] ACTION Review whether the token contract owner should have the ability to generate tokens after the PreSale is finalised

<br />

<hr />

## Notes

* Funds can be contributed to the WCT token contract, or the Presale contract.

* The `Presale.investor_bonus = 25` variable is unused. There is no bonus in any calculations in this set of contracts.

* There is no minimum funding goal, and there is no refund mechanism if the non-existent funding goal is not reached.

* There is a `Presale.minimum_investment` variable where contributions below this amount will be rejected.

* There is a `Presale.pauseContribution(...)` function that will allow the contract owner to pause and restart contributions.

* An account may send ETH to `Presale.proxyPayment(...)` with another account as the token holding account. If the sent ETH results
  in the tokens generated exceeding the cap, an ETH refund will be provided back to the account that sent the ETH, and NOT the token
  holding account. This is the correct behaviour.

* The *MiniMeToken* contract records the `totalSupply` and `balances` in `uint128` data structures. The maximum size of these numbers,
  with 18 decimal places is `new BigNumber("ffffffffffffffffffffffffffffffff", 16).shift(-18)` resulting in
  `340282366920938463463.374607431768211455`. This is sufficient for most ERC20 tokens.

* The *MiniMeToken* contract controller **CANNOT** be set to a multisig contract wallet as all transfers will be disabled.

* The *MiniMeToken* contract `approve(...)` function has the following comment outlining the steps to change an approval limit

  > To change the approve amount you first have to reduce the addresses` allowance to zero by calling `approve(_spender,0)` if it is not
  > already 0 to mitigate the race condition described here: https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

* LOW IMPORTANCE The new *MiniMeToken* contract `claimTokens(...)` function does not check the return status of the token `transfer(...)` method.
  In this case it does not matter as the tokens will just not be transferred.

<br />

<hr />

## Testing

See [test/README.md](test/README.md), [test/01_test1.sh](test/01_test1.sh) and [test/test1results.txt](test/test1results.txt).

<br />

<hr />

## Crowdsale And Token Contracts Overview

* [x] This token contract is of moderate complexity.
* [x] The code has been tested for the normal [ERC20](https://github.com/ethereum/EIPs/issues/20) use cases:
  * [x] Deployment, with correct `symbol()`, `name()`, `decimals()` and `totalSupply()`.
  * [x] `transfer(...)` from one account to another.
  * [x] `approve(...)` and `transferFrom(...)` from one account to another.
* [x] `transfer(...)` and `transferFrom(...)` will only be enabled after the *PreSale* contract is `finalize()`d, AFTER the
  `allowTransfers(...)` is called with a `true` parameter.
* [x] `changeController(...)` does NOT have a `acceptController()` to prevent errorneous transfers of ownership of the token contract.
  This may not be appropriate as this function may need to be called from another contract.
* [x] ETH contributed to the crowdsale contract is NOT accumulated in the crowdsale contract.
* [x] Any ETH or tokens accidentally sent to the *PreSale* contract can be recovered using the `claimTokens(...)` function.
* [x] Check potential division by zero.
* [x] Areas with potential overflow errors in `transfer(...)` and `transferFrom(...)` have the logic to prevent overflows.
* [x] Areas with potential underflow errors in `transfer(...)` and `transferFrom(...)` have the logic to prevent underflows.
* [x] Function and event names are differentiated by case - function names begin with a lowercase character and event names begin 
  with an uppercase character.
* [x] During the crowdsale, ETH can be contributed to the *PreSale* default `function ()` and the `proxyPayment(...)` function. ETH can
  also be contributed to the *WCT* (*MiniMeToken*) default `function ()`.
* [x] The testing has been done using geth v1.6.5-stable-cf87713d/darwin-amd64/go1.8.3 and solc 0.4.11+commit.68ef5810.Darwin.appleclang
  instead of one of the testing frameworks and JavaScript VMs to simulate the live environment as closely as possible.
* [x] The test scripts can be found in [test/01_test1.sh](test/01_test1.sh).
* [x] The test results can be found in [test/test1results.txt](test/test1results.txt) for the results and
  [test/test1output.txt](test/test1output.txt) for the full output.
* [x] There is a switch to pause and then restart the contract being able to receive contributions.
* [x] The [`transfer(...)`](https://github.com/ConsenSys/smart-contract-best-practices#be-aware-of-the-tradeoffs-between-send-transfer-and-callvalue)
  call is the last statements in the control flow of `PreSale.claimTokens(...)` to prevent the hijacking of the control flow.
* [X] The token contract does not implement the check for the number of bytes sent to functions to reject errors from the
  [short address attack](http://vessenes.com/the-erc20-short-address-attack-explained/). This technique is now NOT recommended.
* [x] This contract implement a modified `approve(...)` functions to mitigate the risk of 
  [double spending](https://docs.google.com/document/d/1YLPtQxZu1UAvO9cZ1O2RPXBbT0mooh4DYKjA_jp-RLM/edit#) by requiring the account to set
  a non-zero approval limit to 0 before being to modifying this limit.

<br />

<hr />

## Code Review

* [x] [ERC20.md](code-review/ERC20.md)
  * [x] contract ERC20
* [x] [MiniMeToken.md](code-review/MiniMeToken.md)
  * [x] contract TokenController
  * [x] contract Controlled
  * [x] contract ApproveAndCallFallBack
  * [x] contract MiniMeToken is Controlled
  * [x] contract MiniMeTokenFactory
* [x] [PreSale.md](code-review/PreSale.md)
  * [x] contract PreSale is Controlled, TokenController
    * [x] using SafeMath for uint256
* [x] [SafeMath.md](code-review/SafeMath.md)
  * [x] library SafeMath
* [x] [WCT.md](code-review/WCT.md)
  * [x] contract WCT is MiniMeToken

<br />

Outside Scope:

* [x] [Migrations.md](code-review/Migrations.md) (Used by [truffle](http://truffle.readthedocs.io/en/beta/getting_started/migrations/)).
  * [x] contract Migrations
* [MultiSigWallet.md](code-review/MultiSigWallet.md)

  This is the same source code as the ConsenSys [MultiSigWallet.sol](https://github.com/ConsenSys/MultiSigWallet/blob/e3240481928e9d2b57517bd192394172e31da487/contracts/solidity/MultiSigWallet.sol), with the 
  solidity version upgraded from 0.4.4 to 0.4.11.

  This is also the same source code as Status.im's multisig wallet at [0xa646e29877d52b9e2de457eca09c724ff16d0a2b](https://etherscan.io/address/0xa646e29877d52b9e2de457eca09c724ff16d0a2b#code) 
  currently holding 299,902.24 ethers.

<br />

<hr />

## References

* [Ethereum Contract Security Techniques and Tips](https://github.com/ConsenSys/smart-contract-best-practices)

<br />

<br />

(c) BokkyPooBah / Bok Consulting Pty Ltd for WePower Network - July 26 2017. The MIT Licence.