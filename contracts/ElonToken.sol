// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";

contract ElonToken is ERC20{
    address private _owner;
    //初始代币的名称和代号
    constructor(uint256 initialSupply) ERC20("ElonToken","ELT"){
        _owner=msg.sender;
        _mint(msg.sender,initialSupply*10**decimals());
    }

    modifier onlyOwner(){
        require(msg.sender==_owner,"Only owner can call this function");
        _;
    }
    //允许合约所有者增发代币(可选)
    function mint(address to,uint256 amount)public onlyOwner{
        _mint(to,amount);
    }

    //允许用户销毁自己的代币(可选)
    function burn(uint256 amount)public{
        _burn(msg.sender,amount);
    }
}