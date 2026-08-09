-- 1 расчет количества уникальных пользователей 
select count(distinct id_user) as cnt_user   
from skygame.users 

-- 2 разбиваем пользователей на когорты по месяцам регистрации для последующего анализа
select    date_trunc('month',reg_date) as mm
            , count (id_user) as cnt
from skygame.users
group by mm
order by mm

-- 3 расчет средней длины игровой сессии
select  date_trunc('month', start_session) as mm
            , avg(extract(epoch from end_session - start_session)/(60\*60)) as avg_len_hour
from skygame.game_sessions
where end_session - start_session > interval '5 minute'
group by mm
order by mm 

