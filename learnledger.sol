// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ImmutableEducationRecords
 * @dev A simple immutable education record system on Ethereum.
 * Only the admin (deployer) can add student records.
 * Once added, records cannot be modified or deleted.
 */
contract ImmutableEducationRecords {
    
    address public admin; // Contract owner (e.g., university or authority)
    uint256 public studentCount; // Total number of student records

    struct StudentRecord {
        uint256 id;
        string name;
        string course;
        string grade;
        uint256 timestamp; // When the record was added
    }

    mapping(uint256 => StudentRecord) public records;

    event RecordAdded(uint256 indexed id, string name, string course, string grade, uint256 timestamp);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /**
     * @dev Add a new immutable student record.
     * @param _name The student's name.
     * @param _course The course name.
     * @param _grade The student's grade.
     */
    function addRecord(
        string memory _name,
        string memory _course,
        string memory _grade
    ) public onlyAdmin {
        studentCount++;
        records[studentCount] = StudentRecord(
            studentCount,
            _name,
            _course,
            _grade,
            block.timestamp
        );

        emit RecordAdded(studentCount, _name, _course, _grade, block.timestamp);
    }

    /**
     * @dev Get a student's record by ID.
     * @param _id The record ID.
     */
    function getRecord(uint256 _id) public view returns (
        uint256 id,
        string memory name,
        string memory course,
        string memory grade,
        uint256 timestamp
    ) {
        require(_id > 0 && _id <= studentCount, "Record not found");
        StudentRecord memory record = records[_id];
        return (record.id, record.name, record.course, record.grade, record.timestamp);
    }
}
