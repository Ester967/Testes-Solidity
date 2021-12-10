// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

contract rastreio{
    // Valores predefinidos listados como enums
    enum ShippingStatus {pending, shipped, delivered}
   
    /*Salvar ShippingStatus em uma váriavel chamada status 
    que é privada*/
    ShippingStatus private status;

    //Criação de um evento para avisar quando o pacote chegar
    event LogNewAlert (string description);

    constructor(){
        status = ShippingStatus.pending;
    }

    function shipped() public{
        status = ShippingStatus.shipped;
        emit LogNewAlert("Your package has shipped");
    }

    function delivered() public{
        status = ShippingStatus.delivered;
        emit LogNewAlert("Your package as delivered");
    }

    function getStatus(ShippingStatus _status) internal pure{
        if (ShippingStatus.pending == _status)
            return "Pending";
        if (ShippingStatus.shipped == _status)
            return "Shipped";
        if (ShippingStatus.delivered == _status)
            return "Delivered";
    }

    function Status() public view returns (string memory){
        ShippingStatus _status = status;
        return getStatus(_status);
    }
}