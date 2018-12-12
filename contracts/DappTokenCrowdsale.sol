pragma solidity 0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "../node_modules/openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract DappTokenCrowdsale is Crowdsale, MintedCrowdsale {

    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token
    )
        Crowdsale(_rate, _wallet, _token)
        public
    {

    }

}
