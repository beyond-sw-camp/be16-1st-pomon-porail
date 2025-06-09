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