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
  <summary> 👩‍💻회원</summary>
```
1. 회원가입

delimiter //
create procedure user_join(
in memberIdInput varchar(255), 
in passwordInput varchar(255), 
in nameInput varchar(255), 
in emailInput varchar(255),
in tpNoInput char(13))

begin
	declare memberId varchar(255);
    select member_id into memberId from member where email = emailInput;
    if memberId is not null then
    select '이미 존재하는 아이디입니다.';
    else
    insert into member(member_id, password, name, email, tp_no) 
    values(memberIdInput, passwordInput, nameInput, emailInput, tpNoInput); 
    end if;
end
// delimiter ;

2. 비밀번호 변경

delimiter //
create procedure pw_change(
in idInput bigint,
in passwordInput varchar(255))
begin
	declare memberPw varchar(255);
    declare memberId bigint;
    select seq, password into memberId,memberPw from member where seq = idInput;
		if memberId is null then
		select '존재하지 않는 유저입니다.';
		elseif memberPw =passwordInput then
		select '기존 비밀번호와 동일합니다.';
		else 
		update member set password =passwordInput where id=idInput;
        select '비밀번호 변경이 완료되었습니다.';
		end if;
    end
    // delimiter ;
    
 3. 회원탈퇴
    delimiter //
create procedure member_delete(
in idInput bigint)
begin
	update member set del_yn = 'Y' where seq=idInput;
    select '회원 탈퇴가 완료되었습니다.';
end;
// delimiter ;

4. 로그인

delimiter //
create procedure user_login(
in idInput varchar(255),
in pwInput varchar(255))
begin
	declare count int;
    
 select count(*) into count from member where 
 member_id= idInput and password = pwInput;
 
 if count=1 then
 select '로그인이 완료되었습니다.';
 else 
 select '아이디 또는 비밀번호가 일치하지 않습니다.';
 end if;
end 
// delimiter ;
5. 아이디 찾기
delimiter //
create procedure id_search(
in emailInput varchar(255))
begin
declare memberId varchar(255);
select member_id into memberId from member where email = emailInput;
	if memberId is not null then
	 select concat('고객님의 아이디는: ', memberId, ' 입니다.') as message ;
	else
    select '이메일이 일치하지 않습니다.';
    end if;
end;
 // delimiter ;

6. 비밀번호 찾기
delimiter //
create procedure pw_search(
in idInput varchar(255),
in emailInput varchar(255))
begin
declare memberPw varchar(255);
select password into memberPw from member where member_id= idInput and email = emailInput;
	if memberPw is not null then
	 select concat('고객님의 비밀번호는: ', memberPw, ' 입니다.') as message ;
	else
    select '아이디 또는 이메일이 일치하지 않습니다.';
    end if;
end;
 // delimiter ;
```


</details>
📘조회
📖예매
🧪결




