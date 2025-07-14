//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;
import{Script}from "forge-std/Script.sol";
import {MockV3Aggregator } from "../test/mock.sol";

contract HelperConfig is Script{
    uint8 public constant Decimial=8;
    int256 public constant Initialprice=2000e8;
    NetworkConfig public activeNetworkConfig;
    struct NetworkConfig{
        address price_feed;
    }
    constructor(){
        if(block.chainid ==11155111){
            activeNetworkConfig =sepolia();
        }else if(block.chainid==1){
            activeNetworkConfig=mainnet();
        }
        else{
            activeNetworkConfig=anvil();
        }
    }
    function sepolia()public pure returns (NetworkConfig memory) {
        NetworkConfig memory SepoliaConfig  =NetworkConfig({price_feed:0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return SepoliaConfig;


    }
    function mainnet()public pure returns(NetworkConfig memory) {
        NetworkConfig memory ethconfig =NetworkConfig({
            price_feed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethconfig;  

    }
    function anvil()public returns(NetworkConfig memory) {
        if(activeNetworkConfig.price_feed!=address(0)){
            return activeNetworkConfig;
        }
           vm.startBroadcast();
           MockV3Aggregator mockfeed= new MockV3Aggregator(Decimial,Initialprice);
           vm.stopBroadcast();
           NetworkConfig memory anvilconfig =NetworkConfig({price_feed:address(mockfeed)});
           return anvilconfig;
    }
         
} 