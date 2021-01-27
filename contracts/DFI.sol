// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/GSN/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

/**
 * @dev DFI ERC20 token, including:
 *
 *  - Referenced from OpenZeppelin v3.3 preset: presets/ERC20PresetMinterPauser.sol
 *  - with pauser role and pause functionality removed
 */
contract DFI is Context, AccessControl, ERC20Burnable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    string private _backingAddress = "dZFYejknFdHMHNfHMNQAtwihzvq7DkzV49";

    /**
     * See {ERC20-constructor}.
     */
    constructor() ERC20("DeFiChain Token", "DFI") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        _setupDecimals(8);
    }

    /**
     * @dev Creates `amount` new tokens for `to`.
     *
     * Requirements:
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(address to, uint256 amount) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "DFI: must have minter role to mint");
        _mint(to, amount);
    }

    /**
     * @dev Returns backing address of DFI on DeFiChain
     */
    function backingAddress() public view returns (string memory) {
        return _backingAddress;
    }

    /**
     * @dev Sets and overrides the backing address on DeFiChain
     * Requires admin's role
     */
    function setBackingAddress(string backingAddress) public virtual {
      require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "DFI: must have admin role to set backing address");
      _backingAddress = backingAddress;
    }

}
