// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract PatientManagementSystem{

    //Enum
    enum PatientStatus{Admitted,UnderTreatment,Discharged}
    PatientStatus public status;

    //Admin
    address public admin;

    constructor(){
        admin=msg.sender;
    }

    //Struct
    struct Patient{
        uint id;
        string name;
        uint age;
        string disease;
        address doctor;
        PatientStatus status;
    }

    //Mapping
    mapping(uint=>Patient)public patients;
    mapping(address=>bool)public doctors;

    //Event
    event DoctorAdded(address doctor);
    event DoctorRemoved(address doctor);
    event PatientAdded(uint id, address doctor);
    event StatusUpdated(uint id, PatientStatus status);
    }

    //Modifier
    modifier onlyAdmin() {
        require(msg.sender==admin,"Not Admin");
        _;
    }
    modifier onlyDoctor() {
        require(doctor[msg.sender],"Not Doctor");
        _;
    }

    //Admin function
    function addDoctor(address _doctor) public onlyAdmin {
        doctors[_doctor]=true;
        emit DoctorAdded(_doctor);
    }
    function removeDoctor(address _doctor) public onlyAdmin {
        doctors[_doctor]=false;
        emit DoctorRemoved(_doctor);
    }

    //Doctor function
    function addPatient (uint _id,string memory _name,uint _age,string memory _disease)public onlyDoctor{
        require(pat[_id].id==0,"Patient already exists");
        pat[_id]=Patient(_id,_name,_age,_disease);
        emit PatientAdded(_id,msg.sender);
    }
    function updatePatientStatus(uint _id,PatientStatus _status)public onlyDoctor{
        require(pat[_id].id!=0,"Patient Does not exist");
        pat[_id].status=_status;
        emit StatusUpdated(_id,_status);
    }
    function getPatientDetails(uint _id)public view returns(uint string memory,uint,string memory,address,PatientStatus){
        Patient memory p=pat[_id];
        return (p.id,p.name,p.age,p.doctor,p.status);
    }
    }
