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