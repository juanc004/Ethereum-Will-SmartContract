
// SPDX-License-Identifier: MIT
// Solidity version specification
pragma solidity ^0.8.0;

// Contract Declaration: The Will Contract begins its story
contract Will {
    // State Variables: The main characters in our story
    address public owner; // The protagonist: Owner of the will
    uint public fortune; // The treasure: Total fortune available in the will
    bool public deceased; // The plot twist: Status of the owner, alive or deceased

    // Events: Marking significant points in our story
    event InheritanceSet(address indexed wallet, uint amount); // Notifies when an inheritance is set
    event DeceasedStatusChanged(bool status); // Notifies when the deceased status changes
    event InheritancePaidOut(address indexed beneficiary, uint amount); // Notifies when an inheritance is paid out

    // Constructor: The opening scene where initial settings are established
    constructor() payable {
        require(msg.value > 0, "Initial fortune must be greater than 0"); // Ensuring the story starts with some fortune
        owner = msg.sender; // The creator of the contract becomes the owner
        fortune = msg.value; // Setting up the initial fortune
        deceased = false; // Starting the story with the owner alive
    }

    // Modifiers: The rules and conditions governing the scenes
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner"); // Rule: Only the owner can access
        _; // Continues to the modified function
    }

    modifier mustBeDeceased() {
        require(deceased, "Owner is not deceased"); // Rule: Actions only if owner is deceased
        _; // Continues to the modified function
    }

    // Private State Variables: Supporting characters, not visible to the outside world
    address payable[] private familyWallets; // The beneficiaries
    mapping(address => uint) private inheritance; // The map of inheritances

    // Function: Scene for setting inheritance
    function setInheritance(address payable wallet, uint amountInEther) public onlyOwner {
        uint amountInWei = etherToWei(amountInEther); // Converts Ether to Wei for the story
        require(amountInWei > 0, "Inheritance must be greater than 0"); // Ensuring a meaningful inheritance
        require(wallet != address(0), "Invalid address"); // Validating the beneficiary address

        inheritance[wallet] = amountInWei; // Setting the inheritance
        familyWallets.push(wallet); // Adding the beneficiary to the list

        emit InheritanceSet(wallet, amountInWei); // Announcing the setting of inheritance
    }

    // Function: The climax scene where inheritances are paid out
    function payout() private mustBeDeceased {
        for (uint i = 0; i < familyWallets.length; i++) {
            uint amount = inheritance[familyWallets[i]];
            require(amount > 0, "No inheritance set for this address"); // Ensuring there's an inheritance
            require(address(this).balance >= amount, "Insufficient contract balance"); // Checking contract has enough balance

            familyWallets[i].transfer(amount); // Transferring the inheritance
            emit InheritancePaidOut(familyWallets[i], amount); // Announcing the payout
        }
    }

    // Function: A turning point where the owner is declared deceased
    function declareDeceased() public onlyOwner {
        deceased = true; // Changing the deceased status
        emit DeceasedStatusChanged(deceased); // Announcing the status change

        payout(); // Triggering the payout scene
    }

    // Utility Functions: Tools to convert Ether to Wei and vice versa
    function etherToWei(uint amountInEther) internal pure returns (uint) {
        return amountInEther * 1 ether; // Conversion from Ether to Wei
    }

    function weiToEther(uint amountInWei) internal pure returns (uint) {
        return amountInWei / 1 ether; // Conversion from Wei to Ether
    }

    // View Functions: Scenes for external actors to view the state of our story
    function getFamilyWallets() public view returns (address payable[] memory) {
        return familyWallets; // Returns the list of beneficiary wallets
    }

    function getInheritanceAmount(address wallet) public view returns (uint) {
        return inheritance[wallet]; // Returns the inheritance amount for a given wallet
    }
}
