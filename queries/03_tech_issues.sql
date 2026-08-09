-- Анализ технических сбоев (сессии без end_session).
-- Представлено 3 логических блока для прозрачности расчетов.

-- БЛОК 1: Общее количество и доля битых строк от всех сессий
select 
    sum(case when end_session is null then 1.0 else 0.0 end) as total_broken_sessions,
    sum(case when end_session is null then 1.0 else 0.0 end) / nullif(count(*), 0) as share_broken_total
from skygame.game_sessions;

-- БЛОК 2: Доля проблемных записей для каждого device_type (ios и android)
select 
    u.dev_type,
    sum(case when gs.end_session is null then 1.0 else 0.0 end) / nullif(count(*), 0) as share_broken_by_device
from skygame.game_sessions gs
join skygame.users u on gs.id_user = u.id_user
group by u.dev_type;

-- БЛОК 3: Распределение платформ среди всех проблемных записей
select 
    sum(case when u.dev_type = 'ios' then 1.0 else 0.0 end) / nullif(count(*), 0) as share_ios_in_broken,
    sum(case when u.dev_type = 'android' then 1.0 else 0.0 end) / nullif(count(*), 0) as share_android_in_broken
from skygame.game_sessions gs
join skygame.users u on gs.id_user = u.id_user
where gs.end_session is null
