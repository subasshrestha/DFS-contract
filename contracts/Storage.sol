// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Storage {
    address owner;
    struct FileDetails {
        string fileHash;
        string fileName;
        string fileType;
        uint256 timestamp;
    }
    mapping (address=>FileDetails[]) files;

    event FileAddSuccess(string fileHash, string fileName, string fileType, uint256 timestamp);

    constructor() payable{
        owner = msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function changeOwner(address newOwner) public onlyOwner{
        owner = newOwner;
    }

    function balanceof() public view returns(uint) {   
        return address(this).balance;
    }

    function depositether() public payable{}

    function withdraw() public onlyOwner payable{
        bool sent = payable(msg.sender).send(msg.value);
        require(sent, "Failed to Withdraw");
    }
    
    function addFile(string memory fileHash, string memory fileName, string memory fileType) public{ 
        files[msg.sender].push(FileDetails(fileHash, fileName, fileType, block.timestamp));

        emit FileAddSuccess(fileHash, fileName, fileType, block.timestamp);
    }

    function getAllFiles() public view returns (FileDetails[] memory){
        return files[msg.sender];
    }

    function getFilesCount() public view returns (uint256){
        // uint256 filesCount = 
        return files[msg.sender].length;
    }
}
