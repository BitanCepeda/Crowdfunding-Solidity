// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.7.0 <0.9.0;

contract Name{
    string name = "PlatziCoin";

    function getname() public view returns(string memory){
        return name;
    }
}