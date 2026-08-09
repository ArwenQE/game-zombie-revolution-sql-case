-- Расчет средней выручки на одного человека на один месяц для каждой когорты. Создание адресных маркетинговых акций в зависимости
-- от "щедрости" пользователей.
select  *
      ,extract ('day' from ((select max (dtime_pay) from skygame.monetary) - mm )/30) as interv
      ,avg_rev/( extract ('day' from ((select max (dtime_pay) from skygame.monetary) - mm )/30)) avg_rev_per_month
from (
          select    date_trunc('month', reg_date) as mm
                      , sum(cnt_buy * price) as revenue
                     , count(distinct m.id_user) as cnt
                     , sum(cnt_buy * price) / count(distinct m.id_user) as avg_rev
         from skygame.monetary m
                  join skygame.log_prices p
	   on m.id_item_buy = p.id_item
                 and m.dtime_pay >= p.valid_from
                 and m.dtime_pay <= coalesce(valid_to, to_date('01/01/3000', 'DD/MM/YYYY'))
                 join skygame.users u
                 on m.id_user = u.id_user
                 where reg_date < (select max(dtime_pay) - interval '1 month' from skygame.monetary)
                 group by mm
                 order by mm
       ) t
