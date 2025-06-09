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

---
### 🖌️ 주요 쿼리 요약

#### DDL

```sql
-- 운행상세정보 테이블 생성
create table schedules_detail(
	seq bigint auto_increment, taken_times datetime not null, departure varchar(255) not null,
    destination varchar(255) not null, departure_time datetime not null, 
    destination_time datetime not null, station_detail_seq bigint not null, schedules_seq bigint not null,
	create_at datetime not null default current_timestamp,
    update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq)
);

-- 좌석관리 테이블 생성
create table seat_management(
	seq bigint auto_increment, reservation_seq bigint, is_available enum('true', 'false') not null default 'true',
    price bigint not null, seat_seq bigint not null, schedules_detail_seq bigint not null,
	create_at datetime not null default current_timestamp,
    update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq)
);

```

sql

📚 주요 프로시저
전체 프로시저 바로가기

<details>
  <summary>👉 클릭해서 펼처기 👩‍💻회원</summary>

  여기에 펼쳐질 내용을 작성합니다.  
  여러 줄도 가능합니다.

</details>
📘조회
📖예매
🧪결




