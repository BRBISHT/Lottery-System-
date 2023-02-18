// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
   

contract lottery{

    address public manager;
    address payable[] public player;

    constructor(){
        manager=msg.sender;

    }

    function alreadyentered() view private returns(bool){

        for(uint i=0;i<player.length;i++){
            if(player[i]==msg.sender){
                return true;
            }

        }
        return false;

    }


    function enter() payable public{
        require(msg.sender !=manager,"manager not entered");
        require(alreadyentered()==false," player alreeady entered");
        require(msg.value>=1 ether," minium account mustbe played");
        player.push(payable(msg.sender));
    }
    function random()  view private returns (uint){
        return uint (sha256(abi.encodePacked(block.difficulty,block.number,player)));
    }


    function pick() public{
        require(msg.sender==manager ," only manger can choose the winner");
        uint index=random()%player.length;
        address contractaddress=address(this);
        player[index].transfer(contractaddress.balance);
        player=new address payable[](0);

    }
    function getplayer() view public returns (address payable[] memory){
        return player;
    }
}