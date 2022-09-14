// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Talha is ERC20, ERC20Burnable, Pausable, Ownable {

    mapping (address => bool) rewarded;
    constructor() ERC20("Talha", "TAL") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function getReward() public {
        require(!rewarded[msg.sender], "You have already received the reward");
        _mint(msg.sender, 100 * 10 ** decimals());
    }

    function checkRewarded(address _address) public view returns(bool) {
        return rewarded[_address];
    }

    function buyToken(uint256 _amount) public payable {
        require((msg.value >= (_amount * 100000000000000)), "Not Enough Funds");
        _mint(msg.sender, _amount * 10 ** decimals());
        address payable reciever = payable(owner());
        reciever.transfer(msg.value);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}