 🚂 Porail 🚂

**팀명: POMON**

**팀원**
권수연, 김송옥 임진우, 조은성

## 스택
<p>
<img src="https://img.shields.io/badge/mariaDB-003545?style=for-the-badge&logo=mariaDB&logoColor=white">
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
<img src="https://img.shields.io/badge/visualstudiocode-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white">
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/discord-5865F2?style=for-the-badge&logo=discord&logoColor=white">
</p>


### 💡 프로젝트 개요
<img src="https://github.com/user-attachments/assets/47fdb142-8457-4ce9-9503-32a5aefa0888">

복잡한 기차 예매 시스템을 구축하여 테스트를 해볼 수 있도록 서비스를 기획해 보았습니다.

실제 서비스와의 구현도를 위해 관리자와 유저를 구분하여 DB를 설계 했습니다.

### ✨ 주요 기능

  1. 역 조회 : 등록되어 있는 모든 역을 조회할 수 있습니다.
  
  2. 운행 시간 조회 : 지정한 역 내에서 이용 가능한 시간 대를 조회할 수 있습니다.  
  
  3. 빈 좌석 조회 : 특정 역과 구간 대의 비어있는 좌석 목록을 조회할 수 있습니다. 
  
  4. 예매 : 앞서 선택한 정보를 토대로 특정 좌석에 대한 점유를 할 수 있습니다. 
  
  5. 결제 : 예매 내역으로 가져온 정보를 결제를 통해 예매 완료 상태로 변경할 수 있습니다.

---

## 🗓️ 개발일정
![image](https://github.com/user-attachments/assets/e477754b-af8a-429b-a69b-df0f4c1c460b)



---
## 📝 요구사항정의서
![image](https://github.com/user-attachments/assets/d1dd0f56-9047-4fee-b7ca-0d79e3d4732e)

---
## 📋 ERD
![image](https://github.com/user-attachments/assets/692beb9c-a222-4fdc-984d-7a7289ab704f)


---
### 🖌️ 주요 쿼리 요약

#### DDL

<details>
<summary><b>테이블 생성 DDL</b></summary>
	
```sql
create table member(
seq bigint auto_increment, member_id varchar(255) not null, password varchar(255) not null,
name varchar(255) not null, email varchar(255) not null unique, tp_no char(13) not null,
point_score bigint not null default 0, member_type enum('관리자', '회원') default '회원' not null,
del_yn enum('Y','N') default 'N' not null,create_at datetime not null default current_timestamp,
update_at datetime not null default current_timestamp on update current_timestamp,
primary key(seq));

    
create table payment(
	seq bigint auto_increment, amount bigint not null, type enum('신한', '우리', '국민') not null,
  reservation_seq bigint not null,
	create_at datetime not null default current_timestamp,
	update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));

create table reservation(
	seq bigint auto_increment, member_seq bigint not null, reservation_id varchar(100) not null,
	status enum('예매 완료', '예매 취소') not null, create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq), foreign key(member_seq) references member(seq));
    
create table station(
	seq bigint auto_increment, station_id varchar(255) not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));
    
create table station_detail(
	seq bigint auto_increment, track int not null, station_seq bigint not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));
    
create table schedules(
	seq bigint auto_increment, route_departure varchar(255) not null, route_destination varchar(255) not null,
  route_departure_time datetime not null, route_destination_time datetime not null, train_seq bigint not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));
    
create table schedules_detail(
	seq bigint auto_increment, taken_times time not null, departure varchar(255) not null,
  destination varchar(255) not null, departure_time datetime not null, 
  destination_time datetime not null, station_detail_seq bigint not null, schedules_seq bigint not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));
    
create table train(
	seq bigint auto_increment, train_id varchar(255) not null, type enum('ktx', 'srt', '무궁화') not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));
    
create table seat(
	seq bigint auto_increment, room_id varchar(10) not null, seat_id varchar(10) not null, train_seq bigint not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));
    
create table seat_management(
	seq bigint auto_increment, reservation_seq bigint, is_available enum('true', 'false') not null default 'true',
  price bigint not null, seat_seq bigint not null, schedules_detail_seq bigint not null,
	create_at datetime not null default current_timestamp,
  update_at datetime not null default current_timestamp on update current_timestamp,
	primary key(seq));

```
</details>

</div>
</details>

<hr>

#### DML

<details>
<summary><b>테스트 데이터 입력 DML</b></summary>
	
```sql
delimiter //

-- 프로시저 생성
create procedure insert_data()
begin
		DECLARE i INT DEFAULT 1;
		DECLARE seat INT;
    DECLARE v_price INT;
    DECLARE sd_seq INT DEFAULT 1;
    DECLARE train_seq INT DEFAULT 1;

		-- 회원
    insert into member(member_id, password, name, email, tp_no, point_score) values ('Tp44581', '12345', '권수연', 'tndusl49@naver.com', '010-3032-6432', '0');
		insert into member(member_id, password, name, email, tp_no, point_score) values ('asdlkfj32', '12343', '조은성', 'tasdf9@naver.com', '010-3123-6123', '0');
		insert into member(member_id, password, name, email, tp_no, point_score) values ('asdf123', '12341', '김송옥', 'tnasdf2249@naver.com', '010-1243-6522', '0');
		insert into member(member_id, password, name, email, tp_no, point_score) values ('gsd234', '12342', '임진우', 'dtaasdg239@naver.com', '010-5324-6635', '0');
		insert into member(member_id, password, name, email, tp_no, point_score, member_type) values ('sdf443581', '1234', '김선국', 'asdfasdfl49@naver.com', '010-3132-6640', '0', '관리자');
		-- 기차
		insert into train(train_id, type) values ('ktx001', 'ktx');
		insert into train(train_id, type) values ('ktx005', 'ktx');
		insert into train(train_id, type) values ('ktx075', 'ktx');
		-- 역
		insert into station(station_id) values ('서울');
		insert into station(station_id) values ('광명');
		insert into station(station_id) values ('대전');
		insert into station(station_id) values ('동대구');
		insert into station(station_id) values ('경주');
		insert into station(station_id) values ('울산');
		insert into station(station_id) values ('부산');
		insert into station(station_id) values ('천안아산');
		insert into station(station_id) values ('서대구');
		insert into station(station_id) values ('김천구미');
		insert into station(station_id) values ('오송');
		
		WHILE train_seq <= 3 DO
    SET i = 1;
		    WHILE i <= 180 DO
		        INSERT INTO seat(room_id, seat_id, train_seq) VALUES
		        (
		            CONCAT(FLOOR((i - 1) / 60) + 1, '호차'),                 -- room_id: 1호차, 2호차, 3호차
		            CONCAT(
		                FLOOR(((i - 1) % 60) / 4) + 1,                      -- row_no: 1~15
		                CHAR(65 + ((i - 1) % 4))                            -- col: A~D
		            ),
		            train_seq                                              -- train_seq: 1, 2, 3
		        );
		        SET i = i + 1;
		    END WHILE;
		    SET train_seq = train_seq + 1;
		END WHILE;
		
		set i=1;
		WHILE i <= 11 DO
        INSERT INTO station_detail(track, station_seq) VALUES (1, i);
        INSERT INTO station_detail(track, station_seq) VALUES (2, i);
        INSERT INTO station_detail(track, station_seq) VALUES (3, i);
        INSERT INTO station_detail(track, station_seq) VALUES (4, i);
        SET i = i + 1;
    END WHILE;
		
		-- 스케줄 추가 (전체 여정)
	  insert into schedules(route_departure, route_destination, route_departure_time, route_destination_time, train_seq) values
    ('서울', '부산', '2025-06-09 05:13:00', '2025-06-09 07:50:00', 1);
    insert into schedules(route_departure, route_destination, route_departure_time, route_destination_time, train_seq) values
    ('서울', '부산', '2025-06-09 05:58:00', '2025-06-09 08:43:00', 2);
    insert into schedules(route_departure, route_destination, route_departure_time, route_destination_time, train_seq) values
    ('서울', '부산', '2025-06-09 06:03:00', '2025-06-09 08:49:00', 3);
		
		insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq) values
        (TIMEDIFF('2025-06-09 05:30:00', '2025-06-09 05:13:00'), '서울', '광명', '2025-06-09 05:13:00', '2025-06-09 05:30:00', 2, 1);
    
    insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq) values
        (TIMEDIFF('2025-06-09 06:12:00', '2025-06-09 05:32:00'), '광명', '대전', '2025-06-09 05:32:00', '2025-06-09 06:12:00', 6, 1);
    
    insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq) values
        (TIMEDIFF('2025-06-09 06:56:00', '2025-06-09 06:14:00'), '대전', '동대구', '2025-06-09 06:14:00', '2025-06-09 06:56:00', 10, 1);
        
    insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq) values
        (TIMEDIFF('2025-06-09 07:15:00', '2025-06-09 06:58:00'), '동대구', '경주', '2025-06-09 06:58:00', '2025-06-09 07:15:00', 14, 1);
        
    insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq) values
        (TIMEDIFF('2025-06-09 07:27:00', '2025-06-09 07:16:00'), '경주', '울산', '2025-06-09 07:16:00', '2025-06-09 07:27:00', 18, 1);
        
    insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq) values
        (TIMEDIFF('2025-06-09 07:50:00', '2025-06-09 07:29:00'), '울산', '부산', '2025-06-09 07:29:00', '2025-06-09 07:50:00', 22, 1);

		WHILE sd_seq <= 6 DO
        -- sd_seq별 가격 지정
        IF sd_seq = 1 THEN SET v_price = 8400;
        ELSEIF sd_seq = 2 THEN SET v_price = 21200;
        ELSEIF sd_seq = 3 THEN SET v_price = 19700;
        ELSEIF sd_seq = 4 THEN SET v_price = 8400;
        ELSEIF sd_seq = 5 THEN SET v_price = 8400;
        ELSEIF sd_seq = 6 THEN SET v_price = 8400;
        END IF;

        SET seat = 1;
        WHILE seat <= 180 DO
            INSERT INTO seat_management (
                reservation_seq, is_available, price, seat_seq, schedules_detail_seq
            ) VALUES (
                NULL, 'true', v_price, seat, sd_seq
            );
            SET seat = seat + 1;
        END WHILE;

        SET sd_seq = sd_seq + 1;
    END WHILE;

	-- 2번 회원 (서울 -> 대전 // 1호차 3B (seat_seq=10) // 프로그램에서는 한 트랜잭션 (예매 + 결제)
    insert into reservation(member_seq, reservation_id, status) values
        (2, concat('res', date_format(now(), '%y%m%d'), '-', lpad(2, 5, '0')), '예매 완료');
    update seat_management set is_available='false', reservation_seq=1 where seat_seq=10 and schedules_detail_seq=1;
    update seat_management set is_available='false', reservation_seq=1 where seat_seq=10 and schedules_detail_seq=2;
    -- 결제 내역
    INSERT INTO payment(amount, type, reservation_seq)
		SELECT 
		    SUM(price), '신한', 1
		FROM 
		    seat_management
		WHERE 
		    (seat_seq = 10 AND schedules_detail_seq = 1)
		    OR (seat_seq = 10 AND schedules_detail_seq = 2);
		
end //
delimiter ;

```
</details>

</div>
</details>

<hr/>

#### 주요 기능 프로시저

<details>
<summary><b>회원</b></summary>
	
```sql
--1. 회원가입

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

-- 2. 비밀번호 변경

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
    
--  3. 회원탈퇴
    delimiter //
create procedure member_delete(
in idInput bigint)
begin
	update member set del_yn = 'Y' where seq=idInput;
    select '회원 탈퇴가 완료되었습니다.';
end;
// delimiter ;

-- 4. 로그인

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
 -- 5. 아이디 찾기
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

-- 6. 비밀번호 찾기
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

</div>
</details>

<details>
<summary><b>결제 </b></summary>
	
```sql
// 결제 + 마일리지 추가

select * from payment;
delimiter //
create procedure pay(
in reservationId int,
in payType varchar(255))
begin
declare reservId int;
declare seatPrice bigint;
declare member_id bigint;
declare point bigint;

select sum(sm.price), r.seq into seatPrice, reservId 
from reservation r inner join seat_management sm on 
r.seq = sm.reservation_seq; 

if reservId is not null then
insert into payment(amount,type,reservation_seq) 
values(seatPrice, payType, reservId);

update member m join reservation r on m.seq = r.member_seq
set m.point_score = m.point_score + (seatPrice/0.05); 
end if;
end;

// delimiter ;



```
</details>

</div>
</details>


<details>
<summary><b>조회</b></summary>
	
```sql
-- 예약 가능한 기차 조회
-- 관리자(3) 스케줄 & 스케줄상세 & 좌석관리 추가
start transaction;

-- train_seq 조회
select seq 
from train
where train_id = 'ktx220';

-- 기차가 점유되는 시간을 조회 해야 하고, 등록 시간 내에 기차가 운행중인 스케줄이 있다면 등록 불가. 
select 
case 
when seq is null
then 'true' 
else 'false'
end as result
from schedules  
where train_seq = 1
and route_departure_time >= '2025-06-07 08:10:00'
and route_destination_time <= '2025-06-07 12:40:00';

-- 스케줄 등록
insert into schedules(route_departure, route_destination, route_departure_time, route_destination_time, train_seq) 
values('서울', '부산', '2025-06-07 08:10:00', '2025-06-07 12:40:00', 1);

-- 출발지 정차번호가 출발시간과 도착시간에 이미 사용되고 있으면 스케줄 상세 등록 불가.
-- why? 정차 track에 이미 다른 기차가 스케줄에 등록되어있어 정차 예정임
-- 기차가 정차하면 2분동안 사용자를 태운다고 가정
select 
case 
when seq is null
        then 'true'
        else 'false'
end as result
from schedules_detail
where station_detail_seq = 1
and departure_time between '2025-06-07 08:10:00' and '2025-06-07 08:12:00'
or destination_time between '2025-06-07 08:10:00' and '2025-06-07 08:12:00';

-- schedules_seq 조회
select seq
from schedules
where route_departure = '서울'
and route_destination = '부산';

-- station_detail_seq 조회
select d.seq, d.track, s.station_id 
from station_detail d 
inner join station s on d.station_seq = s.seq
where station_id = '서울역' 
or station_id = '광명역'
or station_id = '천안아산역'
or station_id = '대전역';

-- 스케줄 상세 등록
insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq)
values('00:32:00', '서울역', '광명역', '2025-06-07 08:10:00', ADDTIME('2025-06-07 08:10:00', '00:32:00'), 1, 2);
insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq)
values('00:15:00', '광명역', '천안아산역', '2025-06-07 08:44:00', ADDTIME('2025-06-07 08:44:00', '00:15:00'), 16, 2);
insert into schedules_detail(taken_times, departure, destination, departure_time, destination_time, station_detail_seq, schedules_seq)
values('00:25:00', '천안아산역', '대전역', '2025-06-07 09:01:00', ADDTIME('2025-06-07 09:01:00', '00:25:00'), 7, 2);

-- 좌석 등록은 앞에 train점유 및 track점유만 정상적으로 하고 나면 스케줄 상세 등록에 맞는 seq 좌석을 모두 한번에 등록
-- 가능하므로 별도의 검증이 필요하지 않음.
INSERT INTO seat_management(is_available, price, seat_seq, schedules_detail_seq)
VALUES 
('true', 3000, 1, 3),
('true', 1000, 1, 4),
('true', 2500, 1, 5),
...
('true', 2500, 50, 5);
commit;

```
</details>

</div>
</details>








