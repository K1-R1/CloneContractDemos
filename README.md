# CloneContractDemos


This repo demos usage of Openzeppelin's clone library in order to improve the deployment of factory smart contracts in certain conditions. Clones, as described in [ERC1167](https://eips.ethereum.org/EIPS/eip-1167), are very small, and cheap to deploy, smart-contract that delegates all incoming calls to a master functionality contract. The address of this master contract being stored directly in the contract code, no `sload` is required.

The gas report produced by the tests shows the gas savings one can expect from using clones.

## Examples

1. **ERC20**

  - Gas report:

    | Contract     | Methods        | Gas       |
    | ------------ | -------------- | --------: |
    | FactoryNaive | constructor    | 1,245,959 |
    | FactoryProxy | constructor    | 1,675,235 |
    | FactoryClone | constructor    | 1,305,848 |
    | FactoryNaive | createToken    | 1,179,977 |
    | FactoryProxy | createToken    |   368,401 |
    | FactoryClone | createToken    |   209,109 |
    | FactoryNaive | ERC20.transfer |    51,092 |
    | FactoryProxy | ERC20.transfer |    52,776 |
    | FactoryClone | ERC20.transfer |    51,870 |

2. **UniswapV2**

  - Gas report:

    | Contract               | Methods    | Gas       |
    | ---------------------- | ---------- | --------: |
    | UniswapV2Factory       | createPair | 2,020,039 |
    | UniswapV2FactoryClones | createPair |   218,099 |

  - Comment:

    While deployment cost is greatly reduced, each transaction (including internal transaction) to a pair will require an additional delegate call from the proxy to the `UniswapV2Pair` implementation. These delegate calls, while cheap on a "per-transaction" basis, will eventually make the clone option more expensive to the community.

    It is a good thing that UniswapV2 doesn't use clones for pairs with high volume; however some low-traffic pairs would have benefited from a cheap deployment.

3. **Argent**

  - Gas report:

    | Contract            | Methods                    | Gas     |
    | ------------------- | -------------------------- | ------: |
    | WalletFactory       | createCounterfactualWallet | 322,302 |
    | WalletFactoryClones | createCounterfactualWallet | 265,422 |

## Advantages and disadvanteges of clones

**Advantages**
- Cheaper deployment
- Compatible with proxy based factories
- Cheaper to call than a storage-based proxy

**Disadvantages**
- Non-upgradable
- Calls are more expensive; leading to potentially greater expense in some cases, as outlined for Uniswap above.

## Made with
- Solidity
- Hardhat

## This repo is inspired by;
- Openzeppelin's workshop; [Contract Clones Workshop](https://github.com/OpenZeppelin/workshops/blob/master/02-contracts-clone/README.md)
