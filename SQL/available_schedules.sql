-- 회원(2) 기차 시간 조회
-- 열차 정보, 출발 시간, 출발 역, 도착 시간, 도착 역
-- 사용자가 6월 7일 8시 이후에 서울 > 대전으로 이동한다고 가정.
-- 열차 정보, 출발 시간, 출발 역, 도착 시간, 도착 역
SELECT 
    s.seq AS schedule_seq,
    t.type,
    t.train_id,
    d1.departure_time AS 출발시간,
    d1.departure AS 출발역,
    d2.destination_time AS 도착시간,
    d2.destination AS 도착역
FROM 
    schedules s
INNER JOIN 
    train t ON s.train_seq = t.seq
INNER JOIN 
    schedules_detail d1 ON s.seq = d1.schedules_seq AND d1.departure = '서울'
INNER JOIN 
    schedules_detail d2 ON s.seq = d2.schedules_seq AND d2.destination = '대전'
WHERE 
    d1.departure_time >= '2025-06-07 08:00:00';