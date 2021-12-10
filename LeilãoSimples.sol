// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

contract auction{
    
    address payable public beneficiary;
    uint time_auction; // Tempo da ação
    uint highest_bid; // Oferta mais alta
    address highest_bidder; // Endereço do ofertante
    mapping (address => uint) value_receive; // Valor a receber
    bool ended;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
  
    /// The auction has already ended.
    error AuctionAlreadyEnded();
    /// There is already a higher or equal bid.
    error BidNotHighEnough(uint highest_bid);
    /// The auction has not ended yet.
    error AuctionNotYetEnded();
    /// The function auctionEnd has already been called.
    error AuctionEndAlreadyCalled();

    /// Create a simple auction with `biddingTime`
    /// seconds bidding time on behalf of the
    /// beneficiary address `beneficiaryAddress`.
   
    constructor (address payable beneficiary_, uint limit_time){
        beneficiary = beneficiary_;
        time_auction = limit_time + block.timestamp;
    
     }
     
    function bid() external payable {
        require (msg.value > 0); 
        if (msg.value > highest_bid){
            value_receive[highest_bidder] = highest_bid;
            
            highest_bidder = msg.sender;
            highest_bid = msg.value;

        }

     }

    function withdral() public{
         uint quantity_receive = value_receive[msg.sender];
         value_receive[msg.sender] = 0;

         (bool success,) = msg.sender.call{value: quantity_receive}("");
         require(success); 
     }

    function auctionend() external{
        if (block.timestamp < time_auction)
            revert AuctionNotYetEnded();
        
        if (ended)
            revert AuctionEndAlreadyCalled();

        ended = true;
        emit AuctionEnded(highest_bidder, highest_bid);

        beneficiary.transfer(highest_bid);
    

    }
}