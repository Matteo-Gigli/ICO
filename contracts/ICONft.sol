//SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./ICOToken.sol";
import "./ICOExchange.sol";

pragma solidity ^0.8.4;


contract ICONft is ERC721URIStorage, Ownable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    ICOToken icoToken;
    ICOExchange icoExchange;

    uint public nftSupply;

    string public provenanceHash;



    constructor(uint supplyAmount)ERC721("ICO NFT", "ICON"){
        nftSupply = supplyAmount;
    }



    function initIcoToken(address icoTokenAddress)public onlyOwner{
        icoToken = ICOToken(icoTokenAddress);
    }



    function initIcoExchange(address payable icoExchangeAddress)public onlyOwner{
        icoExchange = ICOExchange(icoExchangeAddress);
    }



    function isApprovedForAll(address owner, address operator)public view virtual override returns (bool){
        return super.isApprovedForAll(owner, operator) || operator == address(icoExchange);
    }




    function ProvenanceHash(string memory _provenanceHash)public onlyOwner{
        provenanceHash = _provenanceHash;
    }



    function _baseURI() internal view virtual override returns (string memory) {
        return provenanceHash;
    }



    function tokenURI(uint256 _tokenId) public override view returns (string memory) {
        string memory tokenId = Strings.toString(_tokenId);
        string memory uri = string(abi.encodePacked(_baseURI(), tokenId, ".json"));
        return uri;
    }



    function mintNft(address tokenOwner)public{
        require(balanceOf(msg.sender) == 0, "Only 1 mint is admitted!");
        uint newId = _tokenIds.current();
        _safeMint(tokenOwner, newId);
        _tokenIds.increment();
    }


    function burnToken(address owner, uint tokenId)external{
        require(owner == ownerOf(tokenId));
        nftSupply -= 1;
        super._burn(tokenId);
    }

}
