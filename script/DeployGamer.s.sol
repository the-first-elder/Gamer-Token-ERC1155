// SPDX-License-Identifier:MIT

pragma solidity ~0.8.22;

import {Script} from "forge-std/Script.sol";
import {Gamer} from "../src/Gamer.sol";

contract DeployGamer is Script {
    Gamer gamer;

    function run() external returns (Gamer) {
        vm.startBroadcast();
        gamer = new Gamer();
        vm.stopBroadcast();
        return gamer;
    }
}
