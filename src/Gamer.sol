// SPDX-License-Identifier: MIT
pragma solidity ~0.8.22;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Gamer is ERC1155, ReentrancyGuard {
    error Gamer__YouOwnAToken();
    error Gamer__YouDontOwnAToken();

    uint256 public constant SOULBOUND = 1;
    uint256 public constant FIRE = 2;
    uint256 public constant EARTH = 3;
    uint256 public constant WATER = 4;

    uint256 public supply = 20000 ether;

    constructor() ERC1155("") {
        _mint(msg.sender, FIRE, 10 ether, "");
        _mint(msg.sender, EARTH, 100 ether, "");
        _mint(msg.sender, WATER, 10 ether, "");
    }

    /*//////////////////////////////////////////////////////////////
                                MODIFIER
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice  modifier to ensure no one meints beyond on nft if balance is equal to 1 it should revert..
     * @param account the address of the sender
     * @param id the id of the token to send
     */
    modifier ownOneToken(address account, uint256 id) {
        uint256 balance = balanceOf(account, id);
        if (balance == 1 ether) {
            revert Gamer__YouOwnAToken();
        }
        _;
    }

    /**
     * @notice modifier to check if an address already has soulBound Token if balance is less than one it should revert
     * @param account the address of the sender
     * @param id the id of the token to send
     */

    modifier youDontOwnASoul(address account, uint256 id) {
        uint256 balance = balanceOf(account, id);
        if (balance < 1 ether) {
            revert Gamer__YouDontOwnAToken();
        }
        _;
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice function to mint Soul Token to mint soulBound token..
     * @param data any data that should be sent
     */
    function mintSoulBound(bytes memory data) public ownOneToken(msg.sender, SOULBOUND) nonReentrant {
        super._mint(msg.sender, SOULBOUND, 1 ether, data);
    }

    /*//////////////////////////////////////////////////////////////
                             SAFE TRANSFER
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice this function transfers other tokens to users who already have soulBound token
     * @param to address of the recepient
     * @param id token id
     * @param amount amount to be sent
     * @param data any data to pass along
     */
    function sendOtherTokens(address to, uint256 id, uint256 amount, bytes memory data)
        public
        youDontOwnASoul(msg.sender, SOULBOUND)
    {
        require(msg.sender != to, "Only owners can transfer items");
        super.safeTransferFrom(msg.sender, to, id, amount, data);
    }

    // TEST....
//     function mintOtherTokens(uint256 id, uint256 value, bytes memory data) public {
//         super._mint(msg.sender, id, value, data);
//     }
// }
