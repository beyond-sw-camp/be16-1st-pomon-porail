-- 같은 출발지, 도착지 / 다른 시간대 출력력
select s1.departure as '출발지', s1.departure_time as '출발시간',
    s2.destination as '도착지', s2.destination_time as '도착시간'
from schedules_detail as s1
inner join schedules_detail s2 on s1.schedules_seq = s2.schedules_seq
where s1.schedules_seq = 1 and s1.departure = '서울' and s2.destination = '부산';

-- 출발지가 서울인 모든 도착지 정보
select s1.departure as '출발지', s1.departure_time as '출발시간',
    s2.destination as '도착지', s2.destination_time as '도착시간'
from schedules_detail as s1
left join schedules_detail s2 on 1
where s1.departure = '서울' and s1.departure_time <= s2.destination_time;