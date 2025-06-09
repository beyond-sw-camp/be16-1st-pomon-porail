-- 관리자(2) 기차 & 좌석 추가
start transaction;

-- train 등록
insert into train(train_id, type) values('ktx220', 'ktx');
insert into train(train_id, type) values('ktx345', 'ktx');
insert into train(train_id, type) values('ktx235', 'ktx');
insert into train(train_id, type) values('ktx667', 'ktx');
insert into train(train_id, type) values('ktx455', 'ktx');
insert into train(train_id, type) values('srt865', 'srt');
insert into train(train_id, type) values('srt098', 'srt');
insert into train(train_id, type) values('mu154', '무궁화');
insert into train(train_id, type) values('ktx459', 'ktx');

-- train_seq 조회
select seq
from train
where train_id = 'ktx220';

-- seat 등록
INSERT INTO seat (room_id, seat_id, train_seq) VALUES ('1호', '1A', '1');
INSERT INTO seat (room_id, seat_id, train_seq) VALUES ('1호', '1B', '1');
INSERT INTO seat (room_id, seat_id, train_seq) VALUES ('1호', '1C', '1');
....

commit;
