//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TecharaNFT is ERC721URIStorage, Ownable {

    uint256 public tokenCounter;

    constructor() 
        ERC721("TecharaNFT", "TNFT") 
        Ownable(msg.sender)   
    {
        tokenCounter = 0;
        Owner = msg.sender;
    }

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner (uint256) {
        require(Owner == msg.sender,"you can't mint");
        require(tokenURI>0, "TokenURI is empty");

        if(tokenCounter>=0)
        {
            tokenCounter++;
        }

        else{
                "NFT limit exceeded";
                }
        }

        uint256 newItemId = tokenCounter; 
        
        _safeMint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        
        tokenCounter++;

        return newItemId;
    }
