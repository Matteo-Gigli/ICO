const { expect } = require("chai");
const { expectRevert} = require('@openzeppelin/test-helpers');


describe("Setting some test for the functionality of the contracts", function() {

    let ICOToken, icoToken, ICOExchange, icoExchange, ICONft, icoNft,
        owner, account1, account2, account3, account4, account5, account6;


    before(async () => {

        [owner, account1, account2, account3, account4, account5, account6] = await ethers.getSigners();

        ICOToken = await ethers.getContractFactory("ICOToken");
        icoToken = await ICOToken.deploy("1000000000000000000000000");


        ICOExchange = await ethers.getContractFactory("ICOExchange");
        icoExchange = await ICOExchange.deploy();


        ICONft = await ethers.getContractFactory("ICONft");
        icoNft = await ICONft.deploy(100);


        await icoToken.deployed();
        await icoExchange.deployed();
        await icoNft.deployed();


        await icoExchange.initIcoToken(icoToken.address);
        await icoExchange.initIcoNft(icoNft.address);
        await icoNft.initIcoToken(icoToken.address);
        await icoNft.initIcoExchange(icoExchange.address);
    })


    it("should revert the buy function if price is incorrect", async()=>{
        await expectRevert(icoExchange.connect(account1).buyIcoTokens(100,{value: "200000000000000000"}),
            "Set Right Price in Wei!");
    })



    it("should be able to buy some tokens", async()=>{
        let balanceAccount1BeforeBuy = await icoToken.balanceOf(account1.address);
        await icoExchange.connect(account1).buyIcoTokens(100,{value: "100000000000000000"});
        let balanceAccount1AfterBuy = await icoToken.balanceOf(account1.address);
        expect(balanceAccount1BeforeBuy).to.be.equal(0);
        expect(balanceAccount1AfterBuy.toString()).to.be.equal("100000000000000000000");

        //Check if our nft is been minted

        let nftBalanceAccount1 = await icoNft.balanceOf(account1.address);
        expect(nftBalanceAccount1).to.be.equal(1);

        let nftTokenIdOwner = await icoNft.ownerOf(0);
        expect(nftTokenIdOwner).to.be.equal(account1.address);
    })


    it("should revert the buy function if you are the owner of the contract", async()=>{
        await expectRevert(icoExchange.buyIcoTokens(100,{value: "100000000000000000"}),
            "Admin: Can't buy tokens!");
    })



    it("should revert the buy function if you already bought tokens", async()=>{
        await expectRevert(icoExchange.connect(account1).buyIcoTokens(100,{value: "100000000000000000"}),
            "Already bought your tokens!");
    })



    it("should revert the claimTokens function if you are not the owner of that Nft tokenId", async()=>{
        await expectRevert(icoExchange.connect(account2).claimTokens(0),
            "Not your Token");
    });



    it("should be able to claim 10 more tokens because you are the owner of nft", async()=>{
        let balanceAccount1BeforeClaim = await icoToken.balanceOf(account1.address);
        let nftBalanceAccount1BeforeClaim = await icoNft.balanceOf(account1.address);
        let nftTotalSupplyBeforeClaim = await icoNft.nftSupply();
        await icoExchange.connect(account1).claimTokens(0);
        let nftBalanceAccount1AfterClaim = await icoNft.balanceOf(account1.address);
        let balanceAccount1AfterClaim = await icoToken.balanceOf(account1.address);
        let nftTotalSupplyAfterClaim = await icoNft.nftSupply();
        expect(balanceAccount1BeforeClaim).to.be.equal("100000000000000000000");
        expect(balanceAccount1AfterClaim).to.be.equal("110000000000000000000");
        expect(nftBalanceAccount1BeforeClaim).to.be.equal(1);
        expect(nftBalanceAccount1AfterClaim).to.be.equal(0);
        expect(nftTotalSupplyBeforeClaim).to.be.equal(100);
        expect(nftTotalSupplyAfterClaim).to.be.equal(99);
    });
});