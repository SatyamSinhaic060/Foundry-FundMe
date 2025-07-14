//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, withdrawFundme} from "../../script/Interactions.s.sol";

contract FundMeTestIntegration is Test {
    address User = makeAddr("user");
    uint256 constant startingvalue = 10 ether;
    uint256 constant SendValue = 10e18;
    FundMe fundme;

    function setUp() external {
        //   fundme = new FundMe();
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
        vm.deal(User, startingvalue);
    }

    function testUsercanfund() public {
        FundFundMe fundfundme = new FundFundMe();
        fundfundme.fundFundMe(address(fundme));

        withdrawFundme withdrawfundme = new withdrawFundme();
        withdrawfundme.WithdrawFundMe(address(fundme));
        assert(address(fundme).balance == 0);
    }
}
