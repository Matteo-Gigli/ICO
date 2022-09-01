//SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.4;


contract ICOToken is ERC20, Ownable{

    uint private _totalSupply;
    mapping(address=>uint) private balances;

    constructor(uint totalSupply)ERC20("ICOToken", "ICT"){
        _totalSupply = totalSupply;
        _mint(owner(), totalSupply);
        balances[owner()] += _totalSupply;
    }



    function increaseAllowance(address spender, uint256 addedValue) public virtual override returns (bool) {
        address owner = owner();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }



    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        balances[from] -= amount;
        balances[to] += amount;
        super._transfer(from, to, amount);
    }



    function balanceOf(address account)public view override returns(uint){
        return balances[account];
    }
}
