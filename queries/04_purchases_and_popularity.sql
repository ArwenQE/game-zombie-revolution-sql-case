-- Динамика суммарных клиентских выплат по месяцам в разрезе по типам продукта.
select  date_trunc('month',dtime_pay) as mm
           , type
           , sum(cnt_buy * price) as revenue
from skygame.monetary m
   join skygame.item_list i
      on m.id_item_buy = i.id_item
   join skygame.log_prices p
		  on m.id_item_buy = p.id_item
      and m.dtime_pay >= p.valid_from
      and m.dtime_pay <= coalesce(valid_to, to_date('01/01/3000', 'DD/MM/YYYY'))
group by   mm
         , type
order by mm

-- Анализ влияния изменения цены на кристаллы на общую выручку. 
select    date_trunc('month',dtime_pay) as mm
	, avg(cnt_buy) as cnt
	 , sum(cnt_buy * price) as revenue
from skygame.monetary m
	   join skygame.item_list i
                  on m.id_item_buy = i.id_item
                 join skygame.log_prices p
		  on m.id_item_buy = p.id_item
      and m.dtime_pay >= p.valid_from
      and m.dtime_pay <= coalesce(valid_to, to_date('01/01/3000', 'DD/MM/YYYY'))
where name_item = 'Crystal'
group by mm
order by mm

