
&lt;br>

&lt;div align="center">
&lt;img src="[의심스러운 링크 삭제됨]" alt="Porail Logo" width="200"/>
&lt;h1>Porail 🚂&lt;/h1>
&lt;p>&lt;strong>모두를 위한 간편하고 빠른 기차 예매 서비스&lt;/strong>&lt;/p>
&lt;p>복잡한 절차 없이 누구나 쉽게 기차표를 검색하고, 좌석을 선택하며, 예매할 수 있는 웹 기반 서비스입니다.&lt;/p>
&lt;/div>

**팀명: POMON**

**팀원**
권수연, 김송옥 임진우, 조은성

&lt;br>
✨ 주요 기능
실시간 열차 조회: 출발지, 도착지, 날짜를 기반으로 실시간 열차 운행 정보를 조회합니다.
간편한 좌석 선택: 직관적인 UI를 통해 원하는 좌석을 쉽게 선택하고 예매할 수 있습니다.
빠른 예매 및 결제: 간편 결제 시스템을 연동하여 빠르고 안전한 예매가 가능합니다. (또는 결제 시뮬레이션)
예매 내역 관리: 마이페이지에서 자신의 예매 내역을 한눈에 확인하고 관리할 수 있습니다.
반응형 웹 디자인: 데스크톱, 태블릿, 모바일 등 모든 기기에서 최적화된 화면을 제공합니다.
&lt;br>

### 💡 프로젝트 배경 및 필요성

---

### 🛠️ 스택 (Tech Stack)

*(여기에 사용된 주요 기술 스택을 기입해주세요. 예: Java, Spring Boot, MySQL, AWS, React 등)*

---

### 🗓️ 개발일정

*(개발일정 문서 링크 또는 이미지 삽입. 예: [개발일정 보기](개발일정_문서_링크) 또는 아래처럼 이미지 삽입)*
---

### 📝 요구사항 정의서

*(요구사항 정의서 문서 링크 또는 이미지 삽입. 예: [요구사항 정의서 보기](요구사항정의서_문서_링크) 또는 아래처럼 이미지 삽입)*
---

### 📋 ERD (Entity Relationship Diagram)

*(ERD 이미지 또는 링크 삽입. 예: [ERD 보기](ERD_링크) 또는 아래처럼 이미지 삽입)*
---

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
