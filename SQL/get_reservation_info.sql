-- 회원(3) 예약 내역 상세 조회
select r.seq as 예약번호, r.reservation_id as 예약명, r.update_at as 예약일
, d.departure as 출발역, d.departure_time as 출발시간
, d.destination as 도착역, d.destination_time as 도착시간
, t.train_id as 기차명, s.room_id as 호차번호, s.seat_id as 좌석번호
from reservation r inner join seat_management m on r.seq = m.reservation_seq
inner join schedules_detail d on d.seq = m.schedules_detail_seq
inner join seat s on s.seq = m.seat_seq
inner join train t on t.seq = s.train_seq
where r.member_seq = 2
and r.update_at between '2025-01-01 :00:00:00' and now();
