-- 1. 회원가입

delimiter //
create procedure user_join(
in memberIdInput varchar(255), 
in passwordInput varchar(255), 
in nameInput varchar(255), 
in emailInput varchar(255),
in tpNoInput char(13))

begin
	declare memberId varchar(255);
    select member_id into memberId from member where email = emailInput;
    if memberId is not null then
    select '이미 존재하는 아이디입니다.';
    else
    insert into member(member_id, password, name, email, tp_no) 
    values(memberIdInput, passwordInput, nameInput, emailInput, tpNoInput); 
    end if;
end
// delimiter ;

--  2. 비밀번호 변경

delimiter //
create procedure pw_change(
in idInput bigint,
in passwordInput varchar(255))
begin
	declare memberPw varchar(255);
    declare memberId bigint;
    select seq, password into memberId,memberPw from member where seq = idInput;
		if memberId is null then
		select '존재하지 않는 유저입니다.';
		elseif memberPw =passwordInput then
		select '기존 비밀번호와 동일합니다.';
		else 
		update member set password =passwordInput where id=idInput;
        select '비밀번호 변경이 완료되었습니다.';
		end if;
    end
    // delimiter ;
    
 -- 3. 회원탈퇴
    delimiter //
create procedure member_delete(
in idInput bigint)
begin
	update member set del_yn = 'Y' where seq=idInput;
    select '회원 탈퇴가 완료되었습니다.';
end;
// delimiter ;

--  4. 로그인

delimiter //
create procedure user_login(
in idInput varchar(255),
in pwInput varchar(255))
begin
	declare count int;
    
 select count(*) into count from member where 
 member_id= idInput and password = pwInput;
 
 if count=1 then
 select '로그인이 완료되었습니다.';
 else 
 select '아이디 또는 비밀번호가 일치하지 않습니다.';
 end if;
end 
// delimiter ;

--  5. 아이디 찾기
delimiter //
create procedure id_search(
in emailInput varchar(255))
begin
declare memberId varchar(255);
select member_id into memberId from member where email = emailInput;
	if memberId is not null then
	 select concat('고객님의 아이디는: ', memberId, ' 입니다.') as message ;
	else
    select '이메일이 일치하지 않습니다.';
    end if;
end;
 // delimiter ;

-- 6. 비밀번호 찾기
delimiter //
create procedure pw_search(
in idInput varchar(255),
in emailInput varchar(255))
begin
declare memberPw varchar(255);
select password into memberPw from member where member_id= idInput and email = emailInput;
	if memberPw is not null then
	 select concat('고객님의 비밀번호는: ', memberPw, ' 입니다.') as message ;
	else
    select '아이디 또는 이메일이 일치하지 않습니다.';
    end if;
end;
 // delimiter ;

 