// SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;
import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SendValue = 0.01 ether;

    function fundFundMe(address mostrecentlydeployed) public payable {
        vm.startBroadcast();
        FundMe(payable(mostrecentlydeployed)).fund{value: SendValue}();

        console.log("funded FundMe with %s", SendValue);
        vm.stopBroadcast();
    }

    function run() external {
        address mostrecentlydeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundFundMe(mostrecentlydeployed);
        vm.stopBroadcast();
    }
}

contract withdrawFundme is Script {
    function WithdrawFundMe(address mostrecentlydeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostrecentlydeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostrecentlydeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        WithdrawFundMe(mostrecentlydeployed);
        vm.stopBroadcast();
    }
}
