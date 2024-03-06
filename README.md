## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## help

```shell
source .env

forge script script/Level00.s.sol:Level00 --rpc-url ${RPC_SEPOLIA}

forge script script/Level01.s.sol:Level01 --broadcast --rpc-url ${RPC_SEPOLIA}

forge script script/Level02.s.sol:Level02 --broadcast --rpc-url ${RPC_SEPOLIA}

forge script script/Level03.s.sol:Deploy --broadcast --rpc-url ${RPC_SEPOLIA}
forge script script/Level03.s.sol:Level03 --broadcast --rpc-url ${RPC_SEPOLIA}

forge script script/Level04.s.sol:Deploy --broadcast --rpc-url ${RPC_SEPOLIA}
forge script script/Level04.s.sol:Level04 --broadcast --rpc-url ${RPC_SEPOLIA}

forge script script/Level05.s.sol:Level05 --broadcast --rpc-url ${RPC_SEPOLIA}

forge script script/Level06.s.sol:Level06 --broadcast --rpc-url ${RPC_SEPOLIA}

forge script script/Level07.s.sol:Level07 --broadcast --rpc-url ${RPC_SEPOLIA}
```
