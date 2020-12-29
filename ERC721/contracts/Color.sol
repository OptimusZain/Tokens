// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Color is ERC721{

string[] public colors;
mapping (string => bool) public colorExists;

    constructor () ERC721("Color","COLOR") public {

    }

    function mint(string memory _color) public {
     
       require(!colorExists[_color]);
       colors.push(_color);
       uint  _id = colors.length;

        _mint(msg.sender, _id);

        colorExists[_color] = true;
       
    }
}