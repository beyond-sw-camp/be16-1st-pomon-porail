delimiter //

create procedure reserve_multi_segment_seat(
    in i_member_id varchar(255),          -- 입력값 1: 회원 id
    in i_schedules_seq bigint,            -- 입력값 2: 운행 정보 id (예: ktx 101편)
    in i_start_station varchar(255),      -- 입력값 3: 출발역 (예: '대전')
    in i_end_station varchar(255),        -- 입력값 4: 도착역 (예: '부산')
    in i_room_id varchar(10),             -- 입력값 5: 객실 번호
    in i_seat_id varchar(10)              -- 입력값 6: 좌석 번호
)
begin
    -- 변수 선언
    declare v_member_seq bigint;
    declare v_seat_seq bigint;
    declare v_reservation_seq bigint;
    declare v_schedules_detail_seq bigint;
    declare v_journey_start_time datetime;
    declare v_journey_end_time datetime;
    declare v_error_flag int default 0;
    declare v_done int default false;

    declare segments_cursor cursor for
        select seq
        from schedules_detail
        where schedules_seq = i_schedules_seq
          and departure_time >= v_journey_start_time
          and destination_time <= v_journey_end_time
        order by departure_time;

    declare continue handler for not found set v_done = true;

    -- 회원 및 좌석 기본 정보 조회
    select seq into v_member_seq from member where member_id = i_member_id;
    select seq into v_seat_seq from seat where room_id = i_room_id and seat_id = i_seat_id
    and train_seq in (select train_seq from schedules where schedules.seq = i_schedules_seq);

    -- 1. 사용자가 입력한 출발역에서 출발하는 시간
	select departure_time into v_journey_start_time
	from schedules_detail
	where schedules_seq = i_schedules_seq and departure = i_start_station
	order by departure_time asc limit 1;

	-- 2. 사용자가 입력한 도착역에 도착하는 시간
	select destination_time into v_journey_end_time
	from schedules_detail
	where schedules_seq = i_schedules_seq and destination = i_end_station
	order by destination_time asc limit 1;

    start transaction;

    -- 예매 정보(reservation) 우선 생성
    insert into reservation (member_seq, reservation_id, status)
    values (v_member_seq, concat('res-', date_format(now(), '%Y%m%d'), lpad(v_member_seq, 5, '0')), '예매 완료');
    set v_reservation_seq = last_insert_id();

    -- 커서를 열고 구간별로 좌석 상태 변경
    open segments_cursor;

    read_loop: loop
        fetch segments_cursor into v_schedules_detail_seq;
        if v_done then
            leave read_loop;
        end if;

        update seat_management
        set reservation_seq = v_reservation_seq, is_available = 'false'
        where seat_seq = v_seat_seq
          and schedules_detail_seq = v_schedules_detail_seq
          and is_available = 'true';

        -- 업데이트 실패 시(이미 예매된 좌석)
        if row_count() = 0 then
            set v_error_flag = 1;
            leave read_loop;
        end if;
    end loop;

    close segments_cursor;

    -- 최종 트랜잭션 처리
    if v_error_flag = 1 then
        select '예약 실패: 일부 구간의 좌석이 이미 예매되었거나 존재하지 않습니다.' as '결과';
        rollback;
    else
        select '예약 성공!' as '결과', v_reservation_seq as '새 예약번호';
        commit;
    end if;

end //

delimiter ;