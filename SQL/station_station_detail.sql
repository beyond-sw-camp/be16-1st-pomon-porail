-- 관리자(1) 역 & 정차역 추가
start transaction;

-- station 등록
insert into station(station_id) values('부산역');
insert into station(station_id) values('대전역');
insert into station(station_id) values('오송역');
insert into station(station_id) values('신탄진역');
insert into station(station_id) values('천안아산역');
insert into station(station_id) values('광명역');
insert into station(station_id) values('영등포역');
insert into station(station_id) values('서울역');

-- station_seq 조회
select seq
from station
where station_id = '서울역' or station_id = '대전역';

-- station_detail 등록
insert into station_detail(track, station_seq) values(1, 8);
insert into station_detail(track, station_seq) values(2, 8);
insert into station_detail(track, station_seq) values(3, 8);
insert into station_detail(track, station_seq) values(4, 8);
insert into station_detail(track, station_seq) values(5, 8);
insert into station_detail(track, station_seq) values(1, 2);
insert into station_detail(track, station_seq) values(2, 2);
insert into station_detail(track, station_seq) values(3, 2);
insert into station_detail(track, station_seq) values(4, 2);
insert into station_detail(track, station_seq) values(5, 2);

commit;