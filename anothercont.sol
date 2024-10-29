// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract HospitalManagementSystem {
    struct Patient {
        string name;
        uint age;
        string disease;
    }

    Patient[] private patients;

    function addPatient(string memory _name, uint _age, string memory _disease) public {
        Patient memory newPatient = Patient({
            name: _name,
            age: _age,
            disease: _disease
        });
        patients.push(newPatient);
    }

    function getPatientCount() public view returns (uint) {
        return patients.length;
    }

    function getPatient(uint index) public view returns (string memory name, uint age, string memory disease) {
        require(index < patients.length, "Patient not found");
        Patient memory patient = patients[index];
        return (patient.name, patient.age, patient.disease);
    }
}
