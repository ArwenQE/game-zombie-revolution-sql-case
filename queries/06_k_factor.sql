-- Расчет вирусности игры в разрезе существующего канала привлечения - приглашения текущих пользователей
with k_faktor as
    (select sum(ref_reg)/count (distinct u.id_user) as k_faktor
    from skygame.users u 
    left join skygame.referral r
         on u.id_user = r.id_user
    ),
avg_volume_cohort as
    (select count(id_user)/count(distinct date_trunc('month', reg_date)) avg_volume
      from skygame.users
    ) 
select avg_volume * k_faktor
from k_faktor, avg_volume_cohort
