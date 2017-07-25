#!/bin/bash
# ----------------------------------------------------------------------------------------------
# Testing the smart contract
#
# Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2017. The MIT Licence.
# ----------------------------------------------------------------------------------------------

MODE=${1:-test}

GETHATTACHPOINT=`grep ^IPCFILE= settings.txt | sed "s/^.*=//"`
PASSWORD=`grep ^PASSWORD= settings.txt | sed "s/^.*=//"`

CONTRACTSDIR=`grep ^CONTRACTSDIR= settings.txt | sed "s/^.*=//"`

ERC20SOL=`grep ^ERC20SOL= settings.txt | sed "s/^.*=//"`
ERC20TEMPSOL=`grep ^ERC20TEMPSOL= settings.txt | sed "s/^.*=//"`
ERC20JS=`grep ^ERC20JS= settings.txt | sed "s/^.*=//"`

MINIMETOKENSOL=`grep ^MINIMETOKENSOL= settings.txt | sed "s/^.*=//"`
MINIMETOKENTEMPSOL=`grep ^MINIMETOKENTEMPSOL= settings.txt | sed "s/^.*=//"`
MINIMETOKENJS=`grep ^MINIMETOKENJS= settings.txt | sed "s/^.*=//"`

PRESALESOL=`grep ^PRESALESOL= settings.txt | sed "s/^.*=//"`
PRESALETEMPSOL=`grep ^PRESALETEMPSOL= settings.txt | sed "s/^.*=//"`
PRESALEJS=`grep ^PRESALEJS= settings.txt | sed "s/^.*=//"`

SAFEMATHSOL=`grep ^SAFEMATHSOL= settings.txt | sed "s/^.*=//"`
SAFEMATHTEMPSOL=`grep ^SAFEMATHTEMPSOL= settings.txt | sed "s/^.*=//"`

WCTSOL=`grep ^WCTSOL= settings.txt | sed "s/^.*=//"`
WCTTEMPSOL=`grep ^WCTTEMPSOL= settings.txt | sed "s/^.*=//"`
WCTJS=`grep ^WCTJS= settings.txt | sed "s/^.*=//"`

DEPLOYMENTDATA=`grep ^DEPLOYMENTDATA= settings.txt | sed "s/^.*=//"`

INCLUDEJS=`grep ^INCLUDEJS= settings.txt | sed "s/^.*=//"`
TEST1OUTPUT=`grep ^TEST1OUTPUT= settings.txt | sed "s/^.*=//"`
TEST1RESULTS=`grep ^TEST1RESULTS= settings.txt | sed "s/^.*=//"`

CURRENTTIME=`date +%s`
CURRENTTIMES=`date -r $CURRENTTIME -u`

# Setting time to be a block representing one day
BLOCKSINDAY=1

if [ "$MODE" == "dev" ]; then
  # Start time now
  STARTTIME=`echo "$CURRENTTIME" | bc`
else
  # Start time 1m 10s in the future
  STARTTIME=`echo "$CURRENTTIME+75" | bc`
fi
STARTTIME_S=`date -r $STARTTIME -u`
ENDTIME=`echo "$CURRENTTIME+60*4" | bc`
ENDTIME_S=`date -r $ENDTIME -u`

printf "MODE                 = '$MODE'\n" | tee $TEST1OUTPUT
printf "GETHATTACHPOINT      = '$GETHATTACHPOINT'\n" | tee -a $TEST1OUTPUT
printf "PASSWORD             = '$PASSWORD'\n" | tee -a $TEST1OUTPUT

printf "CONTRACTSDIR         = '$CONTRACTSDIR'\n" | tee -a $TEST1OUTPUT

printf "ERC20SOL             = '$ERC20SOL'\n" | tee -a $TEST1OUTPUT
printf "ERC20TEMPSOL         = '$ERC20TEMPSOL'\n" | tee -a $TEST1OUTPUT
printf "ERC20JS              = '$ERC20JS'\n" | tee -a $TEST1OUTPUT

printf "MINIMETOKENSOL       = '$MINIMETOKENSOL'\n" | tee -a $TEST1OUTPUT
printf "MINIMETOKENTEMPSOL   = '$MINIMETOKENTEMPSOL'\n" | tee -a $TEST1OUTPUT
printf "MINIMETOKENJS        = '$MINIMETOKENJS'\n" | tee -a $TEST1OUTPUT

printf "PRESALESOL           = '$PRESALESOL'\n" | tee -a $TEST1OUTPUT
printf "PRESALETEMPSOL       = '$PRESALETEMPSOL'\n" | tee -a $TEST1OUTPUT
printf "PRESALEJS            = '$PRESALEJS'\n" | tee -a $TEST1OUTPUT

printf "SAFEMATHSOL          = '$SAFEMATHSOL'\n" | tee -a $TEST1OUTPUT
printf "SAFEMATHTEMPSOL      = '$SAFEMATHTEMPSOL'\n" | tee -a $TEST1OUTPUT

printf "WCTSOL               = '$WCTSOL'\n" | tee -a $TEST1OUTPUT
printf "WCTTEMPSOL           = '$WCTTEMPSOL'\n" | tee -a $TEST1OUTPUT
printf "WCTJS                = '$WCTJS'\n" | tee -a $TEST1OUTPUT

printf "DEPLOYMENTDATA       = '$DEPLOYMENTDATA'\n" | tee -a $TEST1OUTPUT
printf "INCLUDEJS            = '$INCLUDEJS'\n" | tee -a $TEST1OUTPUT
printf "TEST1OUTPUT          = '$TEST1OUTPUT'\n" | tee -a $TEST1OUTPUT
printf "TEST1RESULTS         = '$TEST1RESULTS'\n" | tee -a $TEST1OUTPUT
printf "CURRENTTIME          = '$CURRENTTIME' '$CURRENTTIMES'\n" | tee -a $TEST1OUTPUT
printf "STARTTIME            = '$STARTTIME' '$STARTTIME_S'\n" | tee -a $TEST1OUTPUT
printf "ENDTIME              = '$ENDTIME' '$ENDTIME_S'\n" | tee -a $TEST1OUTPUT

# Make copy of SOL file and modify start and end times ---
`cp $CONTRACTSDIR/$ERC20SOL $ERC20TEMPSOL`
# `cp $CONTRACTSDIR/$MINIMETOKENSOL $MINIMETOKENTEMPSOL`
`cp modifiedContracts/$MINIMETOKENSOL $MINIMETOKENTEMPSOL`
`cp $CONTRACTSDIR/$PRESALESOL $PRESALETEMPSOL`
`cp $CONTRACTSDIR/$SAFEMATHSOL $SAFEMATHTEMPSOL`
`cp $CONTRACTSDIR/$WCTSOL $WCTTEMPSOL`

# --- Modify dates ---
#`perl -pi -e "s/startTime \= 1498140000;.*$/startTime = $STARTTIME; \/\/ $STARTTIME_S/" $FUNFAIRSALETEMPSOL`
#`perl -pi -e "s/deadline \=  1499436000;.*$/deadline = $ENDTIME; \/\/ $ENDTIME_S/" $FUNFAIRSALETEMPSOL`
#`perl -pi -e "s/\/\/\/ \@return total amount of tokens.*$/function overloadedTotalSupply() constant returns (uint256) \{ return totalSupply; \}/" $DAOCASINOICOTEMPSOL`
#`perl -pi -e "s/BLOCKS_IN_DAY \= 5256;*$/BLOCKS_IN_DAY \= $BLOCKSINDAY;/" $DAOCASINOICOTEMPSOL`

DIFFS1=`diff $CONTRACTSDIR/$ERC20SOL $ERC20TEMPSOL`
echo "--- Differences $CONTRACTSDIR/$ERC20SOL $ERC20TEMPSOL ---" | tee -a $TEST1OUTPUT
echo "$DIFFS1" | tee -a $TEST1OUTPUT

DIFFS1=`diff $CONTRACTSDIR/$MINIMETOKENSOL $MINIMETOKENTEMPSOL`
echo "--- Differences $CONTRACTSDIR/$MINIMETOKENSOL $MINIMETOKENTEMPSOL ---" | tee -a $TEST1OUTPUT
echo "$DIFFS1" | tee -a $TEST1OUTPUT

DIFFS1=`diff $CONTRACTSDIR/$PRESALESOL $PRESALETEMPSOL`
echo "--- Differences $CONTRACTSDIR/$PRESALESOL $PRESALETEMPSOL ---" | tee -a $TEST1OUTPUT
echo "$DIFFS1" | tee -a $TEST1OUTPUT

DIFFS1=`diff $CONTRACTSDIR/$WCTSOL $WCTTEMPSOL`
echo "--- Differences $CONTRACTSDIR/$WCTSOL $WCTTEMPSOL ---" | tee -a $TEST1OUTPUT
echo "$DIFFS1" | tee -a $TEST1OUTPUT

echo "var mmOutput=`solc --optimize --combined-json abi,bin,interface $MINIMETOKENSOL`;" > $MINIMETOKENJS

echo "var psOutput=`solc --optimize --combined-json abi,bin,interface $PRESALETEMPSOL`;" > $PRESALEJS

echo "var wctOutput=`solc --optimize --combined-json abi,bin,interface $WCTTEMPSOL`;" > $WCTJS

geth --verbosity 3 attach $GETHATTACHPOINT << EOF | tee -a $TEST1OUTPUT
loadScript("$MINIMETOKENJS");
loadScript("$PRESALEJS");
loadScript("$WCTJS");
loadScript("functions.js");

var mmtfAbi = JSON.parse(mmOutput.contracts["$MINIMETOKENSOL:MiniMeTokenFactory"].abi);
var mmtfBin = "0x" + mmOutput.contracts["$MINIMETOKENSOL:MiniMeTokenFactory"].bin;

var psAbi = JSON.parse(psOutput.contracts["$PRESALETEMPSOL:PreSale"].abi);
var psBin = "0x" + psOutput.contracts["$PRESALETEMPSOL:PreSale"].bin;

var wctAbi = JSON.parse(wctOutput.contracts["$WCTTEMPSOL:WCT"].abi);
var wctBin = "0x" + wctOutput.contracts["$WCTTEMPSOL:WCT"].bin;

// console.log("DATA: mmtfAbi=" + JSON.stringify(mmtfAbi));
// console.log("DATA: psAbi=" + JSON.stringify(psAbi));
// console.log("DATA: psBin=" + psBin);
// console.log("DATA: wctAbi=" + JSON.stringify(wctAbi));

unlockAccounts("$PASSWORD");
printBalances();
console.log("RESULT: ");

// -----------------------------------------------------------------------------
var mmtfMessage = "Deploy MiniMeTokenFactory";
// -----------------------------------------------------------------------------
console.log("RESULT: " + mmtfMessage);
var mmtfContract = web3.eth.contract(mmtfAbi);
var mmtfTx = null;
var mmtfAddress = null;
var mmtf = mmtfContract.new({from: contractOwnerAccount, data: mmtfBin, gas: 4000000},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        mmtfTx = contract.transactionHash;
      } else {
        mmtfAddress = contract.address;
        addAccount(mmtfAddress, "MiniMeTokenFactory");
        printTxData("mmtfAddress=" + mmtfAddress, mmtfTx);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfGasEqualsGasUsed(mmtfTx, mmtfMessage);
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var wctMessage = "Deploy WCT";
// -----------------------------------------------------------------------------
console.log("RESULT: " + wctMessage);
var wctContract = web3.eth.contract(wctAbi);
var wctTx = null;
var wctAddress = null;
var wct = wctContract.new(mmtfAddress, {from: contractOwnerAccount, data: wctBin, gas: 4000000},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        wctTx = contract.transactionHash;
      } else {
        wctAddress = contract.address;
        addAccount(wctAddress, "Token '" + wct.symbol() + "' '" + wct.name() + "'");
        addTokenContractAddressAndAbi(wctAddress, wctAbi);
        printTxData("wctAddress=" + wctAddress, wctTx);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfGasEqualsGasUsed(wctTx, wctMessage);
printTokenContractDetails();
console.log("RESULT: ");

// -----------------------------------------------------------------------------
var psMessage = "Deploy PreSale";
// -----------------------------------------------------------------------------
console.log("RESULT: " + psMessage);
var psContract = web3.eth.contract(psAbi);
var psTx = null;
var psAddress = null;
var ps = psContract.new(wctAddress, {from: contractOwnerAccount, data: psBin, gas: 4000000},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        psTx = contract.transactionHash;
      } else {
        psAddress = contract.address;
        addAccount(psAddress, "PreSale");
        addCrowdsaleContractAddressAndAbi(psAddress, psAbi);
        printTxData("psAddress=" + psAddress, psTx);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfGasEqualsGasUsed(psTx, psMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var wctChangeControllerMessage = "WCT ChangeController To PreSale";
// -----------------------------------------------------------------------------
console.log("RESULT: " + wctChangeControllerMessage);
var wctChangeControllerTx = wct.changeController(psAddress, {from: contractOwnerAccount, gas: 2000000});
while (txpool.status.pending > 0) {
}
printTxData("wctChangeControllerTx", wctChangeControllerTx);
printBalances();
failIfGasEqualsGasUsed(wctChangeControllerTx, wctChangeControllerMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var initialisePresaleMessage = "Initialise PreSale";
// -----------------------------------------------------------------------------
var maxSupply = "1000000000000000000000000";
// Minimum investment in wei
var minimumInvestment = 10;
var startBlock = parseInt(eth.blockNumber) + 5;
var endBlock = parseInt(eth.blockNumber) + 20;
console.log("RESULT: " + initialisePresaleMessage);
var initialisePresaleTx = ps.initialize(multisig, maxSupply, minimumInvestment, startBlock, endBlock,
  {from: contractOwnerAccount, gas: 2000000});
while (txpool.status.pending > 0) {
}
printTxData("initialisePresaleTx", initialisePresaleTx);
printBalances();
failIfGasEqualsGasUsed(initialisePresaleTx, initialisePresaleMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
// Wait until startBlock 
// -----------------------------------------------------------------------------
console.log("RESULT: Waiting until startBlock #" + startBlock + " currentBlock=" + eth.blockNumber);
while (eth.blockNumber <= startBlock) {
}
console.log("RESULT: Waited until startBlock #" + startBlock + " currentBlock=" + eth.blockNumber);
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var validContribution1Message = "Send Valid Contribution";
// -----------------------------------------------------------------------------
console.log("RESULT: " + validContribution1Message);
var validContribution1Tx = eth.sendTransaction({from: account3, to: psAddress, gas: 400000, value: web3.toWei("87", "ether")});
var validContribution2Tx = eth.sendTransaction({from: account4, to: wctAddress, gas: 400000, value: web3.toWei("10", "ether")});
while (txpool.status.pending > 0) {
}
printTxData("validContribution1Tx", validContribution1Tx);
printTxData("validContribution2Tx", validContribution2Tx);
printBalances();
failIfGasEqualsGasUsed(validContribution1Tx, validContribution1Message + " ac3->ps 87 ETH");
failIfGasEqualsGasUsed(validContribution2Tx, validContribution1Message + " ac4->wct 10 ETH");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var validContribution2Message = "Send Valid Contribution";
// -----------------------------------------------------------------------------
console.log("RESULT: " + validContribution2Message);
var validContribution3Tx = eth.sendTransaction({from: account3, to: psAddress, gas: 400000, value: web3.toWei("1", "ether")});
while (txpool.status.pending > 0) {
}
printTxData("validContribution3Tx", validContribution3Tx);
printBalances();
failIfGasEqualsGasUsed(validContribution3Tx, validContribution2Message + " ac3->ps 1 ETH");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var validContribution3Message = "Send Valid Contribution";
// -----------------------------------------------------------------------------
console.log("RESULT: " + validContribution3Message);
var validContribution4Tx = eth.sendTransaction({from: account3, to: psAddress, gas: 400000, value: web3.toWei("3", "ether")});
while (txpool.status.pending > 0) {
}
printTxData("validContribution4Tx", validContribution4Tx);
printBalances();
failIfGasEqualsGasUsed(validContribution4Tx, validContribution3Message + " ac3->ps 3 ETH");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
// Wait until endBlock 
// -----------------------------------------------------------------------------
console.log("RESULT: Waiting until endBlock #" + endBlock + " currentBlock=" + eth.blockNumber);
while (eth.blockNumber <= endBlock) {
}
console.log("RESULT: Waited until endBlock #" + endBlock + " currentBlock=" + eth.blockNumber);
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var claimEthersMessage = "Claim Ethers But No Ethers";
// -----------------------------------------------------------------------------
console.log("RESULT: " + claimEthersMessage);
var claimEthersTx = ps.claimTokens(0, {from: contractOwnerAccount, gas: 2000000});
while (txpool.status.pending > 0) {
}
printTxData("claimEthersTx", claimEthersTx);
printBalances();
passIfGasEqualsGasUsed(claimEthersTx, claimEthersMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var finalisePresaleMessage = "Finalise PreSale";
// -----------------------------------------------------------------------------
console.log("RESULT: " + finalisePresaleMessage);
var finalisePresaleTx = ps.finalize({from: contractOwnerAccount, gas: 2000000});
while (txpool.status.pending > 0) {
}
printTxData("finalisePresaleTx", finalisePresaleTx);
printBalances();
failIfGasEqualsGasUsed(finalisePresaleTx, finalisePresaleMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var cannotTransferMessage = "Cannot Move Tokens Before allowTransfers(...)";
// -----------------------------------------------------------------------------
console.log("RESULT: " + cannotTransferMessage);
var cannotTransfer1Tx = wct.transfer(account6, "1000000000000", {from: account4, gas: 100000});
var cannotTransfer2Tx = wct.approve(account5,  "30000000000000000", {from: account3, gas: 100000});
while (txpool.status.pending > 0) {
}
var cannotTransfer3Tx = wct.transferFrom(account3, account8, "30000000000000000", {from: account5, gas: 200000});
while (txpool.status.pending > 0) {
}
printTxData("cannotTransfer1Tx", cannotTransfer1Tx);
printTxData("cannotTransfer2Tx", cannotTransfer2Tx);
printTxData("cannotTransfer3Tx", cannotTransfer3Tx);
printBalances();
passIfGasEqualsGasUsed(cannotTransfer1Tx, cannotTransferMessage + " - transfer 0.000001 tokens ac4 -> ac6. CHECK no movement");
passIfGasEqualsGasUsed(cannotTransfer2Tx, cannotTransferMessage + " - ac3 approve 0.03 tokens ac5");
failIfGasEqualsGasUsed(cannotTransfer3Tx, cannotTransferMessage + " - ac5 transferFrom 0.03 tokens ac3 -> ac8. CHECK no movement");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var allowTransfersMessage = "Allow Transfers";
// -----------------------------------------------------------------------------
console.log("RESULT: " + allowTransfersMessage);
var allowTransfersTx = ps.allowTransfers(true, {from: contractOwnerAccount, gas: 2000000});
while (txpool.status.pending > 0) {
}
printTxData("allowTransfersTx", allowTransfersTx);
printBalances();
failIfGasEqualsGasUsed(allowTransfersTx, allowTransfersMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var canTransferMessage = "Can Move Tokens After allowTransfers(...)";
// -----------------------------------------------------------------------------
console.log("RESULT: " + canTransferMessage);
var canTransfer1Tx = wct.transfer(account6, "1000000000000", {from: account4, gas: 100000});
var canTransfer2Tx = wct.approve(account5,  "30000000000000000", {from: account3, gas: 100000});
while (txpool.status.pending > 0) {
}
var canTransfer3Tx = wct.transferFrom(account3, account8, "30000000000000000", {from: account5, gas: 200000});
while (txpool.status.pending > 0) {
}
printTxData("canTransfer1Tx", canTransfer1Tx);
printTxData("canTransfer2Tx", canTransfer2Tx);
printTxData("canTransfer3Tx", canTransfer3Tx);
printBalances();
failIfGasEqualsGasUsed(canTransfer1Tx, canTransferMessage + " - transfer 0.000001 tokens ac4 -> ac6. CHECK for movement");
failIfGasEqualsGasUsed(canTransfer2Tx, canTransferMessage + " - ac3 approve 0.03 tokens ac5");
failIfGasEqualsGasUsed(canTransfer3Tx, canTransferMessage + " - ac5 transferFrom 0.03 tokens ac3 -> ac8. CHECK for movement");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var changeControllerMessage = "Change WCT Controller";
// -----------------------------------------------------------------------------
console.log("RESULT: " + changeControllerMessage);
var changeControllerTx = ps.changeWCTController(contractOwnerAccount, {from: contractOwnerAccount, gas: 2000000});
while (txpool.status.pending > 0) {
}
printTxData("changeControllerTx", changeControllerTx);
printBalances();
failIfGasEqualsGasUsed(changeControllerTx, changeControllerMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var canTransfer2Message = "Can Move Tokens After Change Controller";
// -----------------------------------------------------------------------------
console.log("RESULT: " + canTransfer2Message);
var canTransfer4Tx = wct.transfer(account6, "1000000000000", {from: account4, gas: 100000});
var canTransfer5Tx = wct.approve(account5,  "30000000000000000", {from: account3, gas: 100000});
while (txpool.status.pending > 0) {
}
var canTransfer6Tx = wct.transferFrom(account3, account8, "30000000000000000", {from: account5, gas: 200000});
while (txpool.status.pending > 0) {
}
printTxData("canTransfer4Tx", canTransfer4Tx);
printTxData("canTransfer5Tx", canTransfer5Tx);
printTxData("canTransfer6Tx", canTransfer6Tx);
printBalances();
failIfGasEqualsGasUsed(canTransfer4Tx, canTransfer2Message + " - transfer 0.000001 tokens ac4 -> ac6. CHECK for movement");
failIfGasEqualsGasUsed(canTransfer5Tx, canTransfer2Message + " - ac3 approve 0.03 tokens ac5");
failIfGasEqualsGasUsed(canTransfer6Tx, canTransfer2Message + " - ac5 transferFrom 0.03 tokens ac3 -> ac8. CHECK for movement");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var canBurnMessage = "Owner Can Burn Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: " + canBurnMessage);
var canBurnTx = wct.destroyTokens(account3, "1000000000000000001", {from: contractOwnerAccount, gas: 200000});
while (txpool.status.pending > 0) {
}
printTxData("canBurnTx", canBurnTx);
printBalances();
failIfGasEqualsGasUsed(canBurnTx, canBurnMessage);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


EOF
grep "DATA: " $TEST1OUTPUT | sed "s/DATA: //" > $DEPLOYMENTDATA
cat $DEPLOYMENTDATA
grep "RESULT: " $TEST1OUTPUT | sed "s/RESULT: //" > $TEST1RESULTS
cat $TEST1RESULTS
