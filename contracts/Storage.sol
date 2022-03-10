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
    struct PeerDetails {
        address peerAddress;
        string peerName;
        uint256 timestamp;
    }
    mapping (address=>FileDetails[]) files;
    
    PeerDetails [] peers;

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
    
    function addFile(string memory fileHash, string memory fileName, string memory fileType) public payable{ 
        for(uint i = 0; i < peers.length; i++){
            payable(peers[i].peerAddress).transfer(msg.value/peers.length);
        }
        files[msg.sender].push(FileDetails(fileHash, fileName, fileType, block.timestamp));
        emit FileAddSuccess(fileHash, fileName, fileType, block.timestamp);
    }

    function getAllFiles() public view returns (FileDetails[] memory){
        return files[msg.sender];
    }

    function getFilesCount() public view returns (uint256){
        return files[msg.sender].length;
    }

    function addPeer(address peerAddress, string memory peerName) public onlyOwner{
        for(uint i = 0; i < peers.length; i++){
            if(keccak256(abi.encodePacked(peers[i].peerName)) == keccak256(abi.encodePacked(peerName))){
                revert("Peer Already Exists");
            }
        }
        peers.push(PeerDetails(peerAddress, peerName, block.timestamp));
    }

    function removePeer(uint256 index) public onlyOwner{
        for(uint i = index; i < peers.length-1; i++){
            peers[i] = peers[i+1];
        }
        peers.pop();
    }

    function getAllPeers() public view returns (PeerDetails [] memory){
        return peers;
    }

    function getOwner() public view returns (address){
        return owner;
    }
}
