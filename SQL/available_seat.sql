-- 남은 좌석 확인
-- 조회할 운행 스케줄의 id를 지정
set @schedule_detail_seq_to_view = 1;

select s.room_id as '객실', s.seat_id as '좌석번호', sm.price as '가격'
-- 좌석의 예매 상태와 가격 정보가 있는 seat_management를 기준으로
from seat_management sm
-- 좌석의 실제 이름(객실, 좌석번호)을 가져오기 위해 seat 테이블과 조인
join seat s on sm.seat_seq = s.seq
where sm.schedules_detail_seq = @schedule_detail_seq_to_view and sm.is_available = 'true'
order by s.room_id, s.seat_id;