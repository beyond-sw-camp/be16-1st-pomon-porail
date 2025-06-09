# 🚂 Porail 🚂

<img src="./img/medibooker.jpeg" alt="Medibooker" width="1000" height="750"/>

**팀명: POMON**

**팀원**
권수연, 김송옥 임진우, 조은성

## 스택
<p>
<img src="https://img.shields.io/badge/mariaDB-003545?style=for-the-badge&logo=mariaDB&logoColor=white">
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
<img src="https://img.shields.io/badge/datagrip-000000?style=for-the-badge&logo=datagrip&logoColor=white">
<img src="https://img.shields.io/badge/visualstudiocode-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white">
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/jira-0052CC?style=for-the-badge&logo=jira&logoColor=white">
<img src="https://img.shields.io/badge/discord-5865F2?style=for-the-badge&logo=discord&logoColor=white">
</p>

✨ 주요 기능
실시간 열차 조회: 출발지, 도착지, 날짜를 기반으로 실시간 열차 운행 정보를 조회합니다.
예매 내역 관리: 마이페이지에서 자신의 예매 내역을 한눈에 확인하고 관리할 수 있습니다.

### 💡 프로젝트 배경 및 필요성

---

## 🗓️ 개발일정
<img src="./img/WBS.png" alt="개발일정(WBS)" width="1000" height="500"/>

---
## 📝 요구사항정의서
<img src="./img/요구사항정의서.png" alt="요구사항정의서" width="1000" height="500"/>

---
## 📋 ERD
<img src="./img/MediBooker.jpg" alt="ERD" width="1000" height="700"/>

### 🖌️ 주요 쿼리 요약

#### DDL (Data Definition Language)

```sql
-- 환자 테이블 생성
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(30) NOT NULL,
    identity_number VARCHAR(20) NOT NULL UNIQUE,
    patient_phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    patient_authentication ENUM('N', 'Y') DEFAULT 'Y',
    del_yn ENUM('N', 'Y') DEFAULT 'N'
);

-- 진료기록 테이블
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    manager_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    treatment TEXT NOT NULL,
    prescription VARCHAR(255) NOT NULL,
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (patient_id) REFERENCES Patients (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager (manager_id),
    FOREIGN KEY (department_id) REFERENCES Departments (department_id)
);
