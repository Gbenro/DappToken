pragma solidity 0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "../node_modules/openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "../node_modules/openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "../node_modules/openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";

contract DappTokenCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale,TimedCrowdsale {
// Track investor contributions
    uint256 public investorMinCap = 2000000000000000; // 0.002 ether
    uint256 public investorHardCap = 50000000000000000000; // 50 ether
    mapping(address => uint256) public contributions;


    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 _cap,
        uint256 _openingTime,
        uint256 _closingTime
    )
        Crowdsale(_rate, _wallet, _token)
        CappedCrowdsale(_cap)
        TimedCrowdsale(_openingTime, _closingTime)
        public
    {

    }

    /**
     * @dev Returns the amount contributed so far by a sepecific user.
     * @param _beneficiary Address of contributor
     * @return User contribution so far
     */
    function getUserContribution(address _beneficiary)
        public view returns (uint256)
    {
        return contributions[_beneficiary];
    }

    function _preValidatePurchase( 
        address _beneficiary,
        uint256 _weiAmount
        )
         internal 
         {
        super._preValidatePurchase(_beneficiary,_weiAmount);
        uint256 _existingContribution = contributions[_beneficiary];
        uint256 _newContributions = _existingContribution.add(_weiAmount);
        require(
            _newContributions >= investorMinCap && _newContributions <= investorHardCap,
            "Amount invested not in range"
            );
        contributions[_beneficiary] = _newContributions;



    }

}
