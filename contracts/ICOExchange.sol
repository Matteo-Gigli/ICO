//SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./ICOToken.sol";
import "./ICONft.sol";


pragma solidity ^0.8.4;


contract ICOExchange is Ownable, ReentrancyGuard{

    ICOToken private icoToken;
    ICONft private icoNft;

    mapping(address => bool) public retiredTokens;



    constructor(){

    }



    function initIcoToken(address icoTokenAddress)public onlyOwner{
        icoToken = ICOToken(icoTokenAddress);
        icoToken.increaseAllowance(address(this), icoToken.balanceOf(icoToken.owner()));
    }



    function initIcoNft(address icoNftAddress)public onlyOwner{
        icoNft = ICONft(icoNftAddress);
    }



    function buyIcoTokens(uint amount)external payable nonReentrant{
        require(
            msg.sender != owner() &&
            msg.sender != icoToken.owner(),
            "Admin: Can't buy tokens!"
            );
        require(amount > 0, "Amount not accepted!");
        uint unitaryTokenCost = 0.001 ether;
        require(icoToken.balanceOf(msg.sender) == 0, "Already bought your tokens!");
        require(msg.value == unitaryTokenCost * amount, "Set Right Price in Wei!");
        uint decimalsAmount = amount *10**18;
        icoToken.transferFrom(icoToken.owner(), msg.sender, decimalsAmount);
        icoNft.mintNft(msg.sender);
    }




    function claimTokens(uint _tokenIds)public{
        require(retiredTokens[msg.sender] == false, "Tokens already retired");
        require(icoNft.ownerOf(_tokenIds) == msg.sender, "Not your Token");
        retiredTokens[msg.sender] = true;
        uint rewardsNft = 10 * 10**18;
        icoToken.transferFrom(icoToken.owner(), msg.sender, rewardsNft);
    }




    function claimEth()public onlyOwner nonReentrant{
        payable(owner()).transfer(address(this).balance);
    }



    receive()external payable {

    }


}
