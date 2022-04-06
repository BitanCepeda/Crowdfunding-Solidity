// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.7.0 <0.9.0;

contract Asset {
    string public state = "onSale";

    error StateNotDefined(uint unit);

    function changeState(uint _newState) public {
        if(_newState == 0){
            state = "notForSale";
        }
        else if(_newState == 1){
            state = "notForSale";
        }
        else{
            revert StateNotDefined(_newState);
        }
    }

}