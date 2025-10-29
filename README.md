<img width="1919" height="1079" alt="Immutable Education transaction" src="https://github.com/user-attachments/assets/a27698a9-17de-41fd-918a-3c26b5c0583b" />

# 🎓 Immutable Education Records

A transparent, tamper-proof, and blockchain-powered education record system built using **Solidity** and deployed on the **Celo Network**.  
This contract allows an admin (e.g., a university or authorized institution) to securely store immutable student records directly on the blockchain.

---

## 💡 Project Description

**ImmutableEducationRecords** is a decentralized application (dApp) designed to maintain academic integrity and trust in educational records.  
Once a record is added by the admin, it becomes **immutable** — meaning no one can modify or delete it.  
This ensures **transparency**, **permanence**, and **verifiability** of all student academic data.

Built on **Celo**, this project demonstrates how blockchain technology can transform traditional systems into verifiable digital ledgers that empower both institutions and students.

---

## ⚙️ What It Does

- Allows the **admin (deployer)** to add verified student records on-chain.  
- Each record includes:
  - Student ID  
  - Name  
  - Course  
  - Grade  
  - Timestamp (when the record was created)  
- Records are **publicly viewable** by anyone but **cannot be changed or removed**.  
- Promotes **transparency** and **trust** in educational credentials.

---

## 🌟 Features

✅ **Immutable Data** – Once added, records can never be modified or deleted.  
✅ **Admin Control** – Only the deployer (admin) can add records.  
✅ **Public Verification** – Anyone can verify student records on the blockchain.  
✅ **Secure & Transparent** – Built with Solidity on the Celo blockchain.  
✅ **Gas Efficient** – Optimized to minimize storage and transaction costs.  

---

## 💻 Smart Contract Code

```solidity
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
