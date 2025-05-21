## 테이블 개요 파악 
show tables;
select * from users; -- 유저 정보 테이블
select * from checkins; -- 유저들의 강의실 입장하며 남긴 오늘의 다짐 메시지
select * from orders; -- 유저의 수강등록(강좌결제)정보
select * from courses; -- 개설 강좌 정보
select * from enrolleds; -- 유저별 강좌 등록 정보
select * from enrolleds_detail; -- 유저별 들을 수 있는 강좌와 들었는지 여부
select * from point_users; -- 유저별 포인트 점수

-- [실습 목표]
-- 동일한 범주의 데이터를 묶어서 통계를 내주는 Group by 를 이해.
-- 출력하는 데이터를 필드의 값으로 정렬하여 출력하는 Order by 실습.
-- 조금 더 복잡한 분석을 위해 자주 사용되는 유용한 문법을 학습.
-- 데이터 분석의 목적 쌓여있는 날것의 데이터를  의미를 갖는 ' 정보' 로의
-- 통계: 최대 / 최소 / 평균 / 개수

-- 1) 과목별  결제자수를 구해볼까요?
SELECT course_title, count(*) FROM orders GROUP BY course_title; 


-- 2) 성씨별 회원수를 구해보세요.
SELECT name, count(*) FROM users GROUP BY name ORDER BY count(*);

-- 3) 주차별 ' 오늘의 다짐' 갯수 구하기
SELECT week, count(*) FROM checkins GROUP BY week;

-- 4) 주차별 ' 오늘의 다짐' 의 좋아요 최솟값 구하기
SELECT WEEK, MIN(likes) FROM checkins GROUP BY WEEK;

-- 5) 주차별 ' 오늘의 다짐' 의 좋아요 최소값과 최댓값 구하기
SELECT WEEK, MIN(LIKES), MAX(LIKES) FROM checkins GROUP BY WEEK;

-- 만약 좋아요의 최소별, 최대별 주차를 묻는자면?
--  ex) 주차별 '오늘의 다짐'의 좋아요의 최대값을 가지는 주차가 뭘까요?
WITH temp AS(
				SELECT WEEK, MIN(likes) AS MIN_WEEK, MAX(likes) AS MAX_WEEK FROM checkins GROUP BY WEEK)
				SELECT WEEK FROM temp WHERE MAX_WEEK = (SELECT MAX(MAX_WEEK) FROM temp);


-- 6) 주차별 ' 오늘의 다짐' 의 좋아요 합계값 및 평균값 구하기
SELECT WEEK, SUM(LIKES), AVG(LIKES) FROM checkins GROUP BY WEEK;

-- 7) like 를 많이 받은 순서대로 ' 오늘의 다짐' 을 출력해 보기
SELECT WEEK, comment, LIKES FROM checkins ORDER BY LIKES DESC;

-- 8) 회원수가 많은 성씨별로 조회해보기
SELECT name, count(*) AS cnt FROM users GROUP BY name ORDER BY cnt DESC;
 

-- 9) 웹개발 종합반의 결제수단별 주문건수를 건수가 많은 순서대로 출력해 보세요.


-- 10) Gmail 을 사용하는 성씨별 회원수 세어보기


-- 11) course_id 별 ' 오늘의 다짐' 에 달린 평균 like 개수 구해보기



-- 12) 네이버 이메일을 사용하여 앱개발 종합반을 신청한 주문의 결제수단별 주문건수를 적은 순서대로 출력하세요.



