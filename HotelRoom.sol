pragma solidity ^0.8.7;

contract HotelRoom{

    //vacancy status of the hotel room 
    enum Statuses {Vacant , Occupied}
    Statuses currentStatus;

    //record and emit event
    event Occupy(address _occupant, uint _value);

    address payable public  owner; 
    
    constructor() {
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant{
        //update status after booking;
        require(currentStatus == Statuses.Vacant, "currently occupied.");
        _;
    }

    modifier costs(uint _amount){
         //check price;
        require(msg.value >= 2 ether, " insufficient balance");
        _;
    }

    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) OnlyOwner{
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender,msg.value);
    }
}