//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    address User = makeAddr("user");
    uint256 constant startingvalue = 10 ether;
    uint256 constant SendValue = 0.1e18;
    uint256 constant gasprice = 1;
    FundMe fundme;

    function setUp() external {
        //   fundme = new FundMe();
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
        vm.deal(User, startingvalue);
    }

    function testMinimum() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testPriceVersion() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function testfundfail() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testfundupdate() public {
        vm.prank(User);
        fundme.fund{value: SendValue}();
        uint256 amountFunded = fundme.getaddressto(User);
        assertEq(amountFunded, SendValue);
    }

    modifier funded() {
        vm.prank(User);
        fundme.fund{value: SendValue}();
        _;
    }

    function testAddsFund() public {
        vm.prank(User);
        fundme.fund{value: SendValue}();
        address funder = fundme.getfunder(0);
        assertEq(funder, User);
    }

    function testonlyowner() public funded {
        vm.prank(User);
        vm.expectRevert();

        fundme.withdraw();
    }

    function testwithdraw() public funded {
        uint256 startingownerbalance = fundme.getowner().balance;
        uint256 startingFundMe = address(fundme).balance;
        vm.prank(fundme.getowner());
        fundme.withdraw();
        uint endingowner = fundme.getowner().balance;
        uint endingFundme = address(fundme).balance;
        assertEq(endingFundme, 0);
        assertEq(startingFundMe + startingownerbalance, endingowner);
    }

    function testmultipleowner() public funded {
        uint160 numberoffunder = 10;
        uint160 funderindex = 1;
        for (uint160 i = funderindex; i < numberoffunder; i++) {
            hoax(address(i), SendValue);
            fundme.fund{value: SendValue}();
        }
        uint256 startingownerbalance = fundme.getowner().balance;
        uint256 startingFundMe = address(fundme).balance;
        vm.startPrank(fundme.getowner());
        fundme.withdraw();
        vm.stopPrank();
        assert(address(fundme).balance == 0);
        assert(
            startingFundMe + startingownerbalance == fundme.getowner().balance
        );
    }
}
