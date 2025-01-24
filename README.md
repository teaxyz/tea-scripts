## Tea Scripts

This repo contains scripts to run on a local devnet of the Layer Tea network to verify the network's functionality.

### Prerequisites

- Run a local devnet, and save the L2 RPC URL.
- Set `PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` in your environment (this corresponds to a prefunded address on the devnet)
- Set `OWNER_PRIVATE_KEY=???` in your environment (this is the address who can update the fallback price and oracle)
- Run the `Deploy.s.sol` and `Airdrop.s.sol` scripts on the `GPGWallet` repo (you must use the same `PREFUNDED_PRIVATE_KEY` for these transactions so signatures are consistent).

### GPG Wallet Script

- Copy the address of the wallet with the `0x49CEB217B43F2378` Key ID to `AddSigner.s.sol` (which corresponds to the GPG key used to provide the signature in that script)
- Run `forge script --rpc-url [L2RPC] script/GPGWallet/AddSigner.s.sol:AddSignerScript --broadcast`
- Verify that the transaction succeeded and the terminal output confirms the signer was added

### L1 Data Fee Script

- We want to test that the data fee is adjusted for the currency, is responsive to the fallback price changing, and is responsive to an oracle.
- Note that after these transactions go through, the updates aren't propagated until the next epoch, so we need to wait at least 15-20 seconds between transactions.
- First, fund the owner account with ETH for transactions by calling `forge script --rpc-url [L2RPC] script/L1DataFee/FundOwner.s.sol:FundOwnerScript --broadcast`.
- Wait approximately 5 minutes for the L1BaseFee to fall to the minimum. You can check this with `cast call --rpc-url [L2RPC] 0x4200000000000000000000000000000000000015 "basefee()"`. It should return `0x7`.
- Run `forge script --rpc-url [L2RPC] script/L1DataFee/SendL2Tx.s.sol:SendL2Tx --broadcast` to send a transaction. Once the transaction is completed, use the tx hash to get the receipt with `cast receipt --rpc-url [L2RPC] [TX_HASH]`. The L1 Data Fee should be 16.8 billion or `0x3e95ba800`.
- Now, let's set a fallback. Run `forge script --rpc-url [L2RPC] script/L1DataFee/UpdateFallback.s.sol:UpdateFallbackScript --broadcast`. Wait for at least 15-20 seconds for the update to push through to the oracle. Then call the SendL2Tx transaction again, and use the tx hash to get the receipt with `cast receipt --rpc-url [L2RPC] [TX_HASH]`. The fallback should be set to 11.2 billion or `0x29b927000`.
- Finally, let's set an oracle. Run `forge script --rpc-url [L2RPC] script/L1DataFee/UpdateOracle.s.sol:UpdateOracleScript --broadcast`. Wait for at least 15-20 seconds for the update to push through to the oracle. Then call the SendL2Tx transaction again, and use the tx hash to get the receipt with `cast receipt --rpc-url [L2RPC] [TX_HASH]`. The oracle should be set to 22.4 billion or `0x53724e000`.
