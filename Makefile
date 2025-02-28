-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv --verify --broadcast

DEFAULT_ANVIL_KEY:=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo usage
	@echo " make deploy [ARGS=...]\n example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo " make fund [ARGS=...]\n example: make fund ARGS=\"--network sepolia\""


#Clean the Repo
clean :; forge clean

#Remove Modules
remove:; rm -rf .gitmodules && rm -rf .git/modules && -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install:; forge install cyfrin/foundry-devops@0.3.0 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit

build:; forge build

test:; forge test

snapshot:; forge snapshot

format:; forge fmt

anvil:; anvil

NETWORK_ARGS := --rpc-url http://127.0.0.1:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:; forge script script/DeployFundMe.s.sol:DeployFundMe $(NETWORK_ARGS)
