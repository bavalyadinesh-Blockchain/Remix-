// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract StudentDetails{

//1.Enum
 
 enum Department{Biology,ComputerScience,English,Mathematics,Physics}
 Department public dep;

 enum Gender{Male,Female,Others}
 Gender public gen;

 //2.Admin
  address public admin;
 constructor()
{
    admin=msg.sender;
} 

//3.Struct
struct Student{
    uint rollno;
    string name;
    Department dep;
    Gender gen;
    string year;
    address Admin;
    
}

//4.Mapping

mapping(uint => Student) public stud;
mapping(address => bool) public isAdmin; // to check if the address is an admin)

//Event
event StudentAdded(address Admin);
event StudentRemoved(address Admin);
event StudentDetailsAdded(uint rollno,address Admin);
event StudentUpdated(uint rollno, address Admin);

//Modifier

modifier OnlyAdmin{
    require(isAdmin[msg.sender], "Only Admin can access");
    _;
}

//Admin function
function addStudent(address _Admin)public OnlyAdmin{
    isAdmin[_Admin] = true;
    emit StudentAdded(_Admin);
}

function removeStudent(address _Admin)public OnlyAdmin{
    isAdmin[_Admin] = false;
    emit StudentRemoved(_Admin);
}

//Add Student 

function addStudent(uint _rollno, string memory _name, Department _dep, Gender _gen, string memory _year,address _Admin) public OnlyAdmin{
require(stud[_rollno].rollno == 0,"Student already exists");
stud[_rollno]=Student(_rollno,_name,_dep,_gen,_year,_Admin);
emit StudentAdded(msg.sender);    
}

//Update Student

function updateStudentStatus(uint _rollno,address _Admin) public OnlyAdmin{
     require(stud[_rollno].rollno != 0,"Student does not exist");
    stud[_rollno].Admin = _Admin;
    emit StudentUpdated(_rollno,msg.sender);
}

//get Student details

function getStudentDetails(uint _rollno) public view returns( uint,string memory,Department ,Gender,string memory,address)
    {
        Student memory p=stud[_rollno];
        return(p.rollno,p.name,p.dep,p.gen,p.year,p.Admin);
}

}

