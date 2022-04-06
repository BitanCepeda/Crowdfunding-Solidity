// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.7.0 <0.9.0;

contract Projects{

    //enum
    enum ProjectState {Incomplete, Complete}

    //Storage struct
    struct Project{
        address dir;
        address payable wallet;
        string name;
        uint totalAmount;
        uint collected;
        ProjectState isFull;
    }

    //Structs creation - array
    Project public project1 = Project(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, payable(address(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2)), "andres", 10000000000000000000, 0, ProjectState.Incomplete);
    Project public project2 = Project(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, payable(address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db)), "Beto", 20000000000000000000, 0, ProjectState.Incomplete);
    Project public project3 = Project(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB, payable(address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB)), "andres", 30000000000000000000, 0, ProjectState.Incomplete);


    //Events 
    event MoneyInput(
        address from,
        uint project,
        uint amount
    );

    event ProjectChange(
        uint numberChangeProject
    );


    //Modifiers
    modifier noWner(){
        require(
               msg.sender != project1.dir &&  msg.sender != project2.dir &&  msg.sender != project3.dir,
            "The owners can't aport money for their own project"
        );
        //la función se inserta donde aparece el símbolo
        _;
    }

    //errors
    error stateOrInputInvalid(uint input, ProjectState full1, ProjectState full2, ProjectState full3);

    //mappings
    mapping(address => uint) public contributions;
  

    function fundProject(uint  _number) public payable noWner returns(string memory stateTx, uint valor, uint collected){
        require(msg.value > 0, "The aport amount should be greater than 0 wei");

       if(_number>=1 && _number<=3){
        valor= msg.value;
        
            if(_number==1 && project1.isFull == ProjectState.Incomplete){
                project1.wallet.transfer(msg.value); //send money
                project1.collected += msg.value; //+ at the counter
                stateTx = "success";
                collected = project1.collected;
                if(project1.collected>=project1.totalAmount){
                    changeProjectState(1);
                }
        }

            else if(_number==2 && project2.isFull == ProjectState.Incomplete){
                project2.wallet.transfer(msg.value); //send money
                project2.collected += msg.value; //+ at the counter
                stateTx = "success";
                collected = project2.collected;
                if(project2.collected>=project2.totalAmount){changeProjectState(2);}
        }

            else if(_number==3 && project3.isFull == ProjectState.Incomplete){
                project3.wallet.transfer(msg.value); //send money
                project3. collected += msg.value; //+ at the counter
                stateTx = "success";
                collected = project3.collected;
                if(project3.collected>=project3.totalAmount){changeProjectState(3);}
        }
        else{
            revert stateOrInputInvalid(_number, project1.isFull, project2.isFull, project3.isFull);
        }

       }
       else{
           revert stateOrInputInvalid(_number, project1.isFull, project2.isFull, project3.isFull);
       }   

       //evento de vuelta- 
       emit MoneyInput(msg.sender, _number, msg.value);

       //mapping
       contributions[msg.sender] = msg.value;
    }

    function changeProjectState(uint _option) private{

        if(_option>=1 && _option<=3){
        if(_option==1){project1.isFull=ProjectState.Complete;}
        if(_option==2){project2.isFull=ProjectState.Complete;}
        if(_option==3){project3.isFull=ProjectState.Complete;}
      }
        emit ProjectChange(_option);
    }

    function getBalances(uint _number) public view returns(uint balance){
        if(_number>=1 && _number<=3){
            if(_number==1){balance=project1.collected;}
            if(_number==2){balance=project2.collected;}
            if(_number==3){balance=project3.collected;}
        }
    }

}