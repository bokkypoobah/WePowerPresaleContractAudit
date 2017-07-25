# WCT

Source file [../../contracts/WCT.sol](../../contracts/WCT.sol)

<br />

<hr />

```javascript
// BK Ok
pragma solidity ^0.4.11;


// BK Ok
import "./MiniMeToken.sol";


/**
 * @title WePower Contribution Token
 *
 * @dev Simple ERC20 Token, with pre-sale logic
 * @dev IMPORTANT NOTE: do not use or deploy this contract as-is. It needs some changes to be
 * production ready.
 */
contract WCT is MiniMeToken {
  /**
    * @dev Constructor
  */
  // BK Ok - Constructor
  function WCT(address _tokenFactory)
    // BK Ok
    MiniMeToken(
      _tokenFactory,
      0x0,                     // no parent token
      0,                       // no snapshot block number from parent
      "WePower Contribution Token", // Token name
      18,                      // Decimals
      "WCT",                   // Symbol
      true                     // Enable transfers
    ) {}
}
```