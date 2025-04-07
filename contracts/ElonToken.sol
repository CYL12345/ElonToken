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

    //重写transfer函数
    function transfer(address recipient,uint256 amount)public override returns(bool){
        require(amount>0,"Amount must be greater than zero");
        require(balanceOf(msg.sender)>=amount,"Insufficient balance");
        emit Transfer(msg.sender,recipient,amount);
        return true;        
    }

    //重新approve函数，授权
    function approve(address spender,uint256 amount)public override returns(bool){
        require(amount>0,"Amount must be greater than zero");
        require(spender!=address(0),"Invalid spender address");
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    //重写transferFrom函数。被授权方将授权的代币转移给指定的接收者
    function transferFrom(address sender,address recipient,uint256 amount)public override returns(bool){
        require(amount>0,"Amount must be greater than zero");
        require(balanceOf(sender)>=amount,"Insufficient balance");
        require(allowance(sender,msg.sender)>=amount,"Insufficient allowance");
        emit Transfer(sender,recipient,amount);
        return true;
    }

    //重新mint函数，允许合约所有者增发代币
    function mint(address to,uint256 amount)public onlyOwner{
        require(amount>0,"Amount must be greater than zero");
        _mint(to,amount);
    }

    //重新burn函数，允许用户销毁自己的代币
    function burn(uint256 amount)public{
        require(amount>0,"Amount must be greater than zero");
        _burn(msg.sender,amount);
    }
}