-- DAU запрос
select date_trunc ('day', start_session) as day_start 
          , count (distinct id_user) as cnt_user 
from skygame.game_sessions
group by day_start 

-- WAU запрос
select date_trunc ('week', start_session) as week_start 
          , count (distinct id_user) as cnt_user 
from skygame.game_sessions
group by week_start 

--MAU запрос
select date_trunc ('month', start_session) as month_start 
          , count (distinct id_user) as cnt_user 
from skygame.game_sessions
group by month_start
