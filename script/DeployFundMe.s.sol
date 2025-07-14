// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;
import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig helperconfig = new HelperConfig();
        address ethUsd = helperconfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundme = new FundMe(ethUsd);
        vm.stopBroadcast();
        return fundme;
    }
}
