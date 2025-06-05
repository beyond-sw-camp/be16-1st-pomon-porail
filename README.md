## 🏥 MediBooker 🏥

**팀명: JJOB_DOC**

**팀원**

| 역할   | 이름   |
| :----- | :----- |
| 팀장   | 김지은 |
| 팀원   | 김창현 |
| 팀원   | 박수현 |

---

### 📢 프로젝트 소개

**MediBooker**는 환자와 병원 모두를 위한 혁신적인 의료 예약 서비스입니다. 환자는 간편하게 병원에 접수하고, 실시간 대기 순번을 확인하며, 진료 및 처방 내역을 손쉽게 조회할 수 있습니다.

특히, 바쁜 직장인들은 **원격 대기 기능**을 통해 병원 방문 전 대기 시간을 줄이고 복잡한 접수 절차를 생략할 수 있습니다. 또한, 진료 내역서나 처방 내역서를 발급받기 위해 병원을 재방문하거나 팩스를 이용해야 하는 번거로움을 해소하고, 모바일 앱을 통해 편리하게 확인할 수 있습니다.

병원에서는 MediBooker를 통해 환자 접수를 효율적으로 관리하고, 진료 및 처방 내역을 체계적으로 제공할 수 있습니다. 원격 접수와 사용자 인증 기능은 복잡한 접수 절차와 환자 정보 입력 과정을 간소화하여 병원 운영의 효율성을 높입니다.

---

### 💡 프로젝트 배경 및 필요성

최근 의료법 개정으로 병원 방문 시 신분증 제시가 의무화되었습니다. 이는 삼성페이, 애플페이 등 모바일 결제 서비스를 주로 사용하는 사용자들에게 불편을 초래하고 있습니다. PASS 앱 등을 통해 신분증 확인이 가능하지만, 병원 접수처의 혼잡을 가중시킬 수 있다는 단점이 있습니다.

또한, 병원 접수 후 자신의 대기 순번을 알기 어려워 대기 시간을 예측하기 힘들다는 점, 특히 평일 낮 시간에 병원 방문이 어려운 직장인들에게는 큰 불편으로 작용합니다.

이러한 문제점을 해결하고자 저희 **JJOB_DOC** 팀은 원격 줄서기 서비스를 핵심 기능으로 하는 MediBooker를 개발하게 되었습니다. 본 서비스를 통해 사용자들은 접수 및 대기 시간의 불편함을 해소하고, 앱을 통해 진료 및 처방 내역을 편리하게 확인하며 의료 서비스 이용 경험을 크게 향상시킬 수 있을 것입니다.

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
