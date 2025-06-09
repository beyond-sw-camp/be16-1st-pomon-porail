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