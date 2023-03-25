pragma solidity ^0.8.0;

contract HealthRecord {
    struct Record {
        string name;
        string dob;
        string bloodType;
        string[] medications;
        string[] conditions;
        string[] allergies;
    }

    mapping (address => Record) private records;

    event RecordCreated(address indexed owner, string name);

    function createRecord(string memory name, string memory dob, string memory bloodType) public {
        require(bytes(name).length > 0, "Name is required");
        require(bytes(dob).length > 0, "DOB is required");
        require(bytes(bloodType).length > 0, "Blood type is required");

        require(records[msg.sender].medications.length == 0, "Record already exists for this address");

        Record storage record = records[msg.sender];
        record.name = name;
        record.dob = dob;
        record.bloodType = bloodType;

        emit RecordCreated(msg.sender, name);
    }

    function addMedication(string memory medication) public {
        require(bytes(medication).length > 0, "Medication is required");

        Record storage record = records[msg.sender];
        require(bytes(record.name).length > 0, "Record does not exist for this address");

        record.medications.push(medication);
    }

    function addCondition(string memory condition) public {
        require(bytes(condition).length > 0, "Condition is required");

        Record storage record = records[msg.sender];
        require(bytes(record.name).length > 0, "Record does not exist for this address");

        record.conditions.push(condition);
    }

    function addAllergy(string memory allergy) public {
        require(bytes(allergy).length > 0, "Allergy is required");

        Record storage record = records[msg.sender];
        require(bytes(record.name).length > 0, "Record does not exist for this address");

        record.allergies.push(allergy);
    }

    function getRecord(address owner) public view returns (string memory, string memory, string memory, string[] memory, string[] memory, string[] memory) {
        Record storage record = records[owner];
        return (record.name, record.dob, record.bloodType, record.medications, record.conditions, record.allergies);
    }
}
