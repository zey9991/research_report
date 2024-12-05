with days as (
    select * from UNNEST(sequence(date('2021-10-14'), date(cast(now() as timestamp)), interval '1' day)) as day(day)
  )
,daily_users as (
   select * from query_3086072
)
,daily_stats as (
  select a.day,
       avg(c.daily_users) OVER (ORDER BY a.day ROWS BETWEEN 29 PRECEDING AND 0 FOLLOWING) AS "30d-ma Traders",
       c.daily_users, c.new_users, c.returned_users, c.cumulative_users
  from days a 
    left join daily_users c on a.day = c.day
)

-- select * from daily_stats
select * from daily_stats
where day >=  cast( '{{start_date}}' as TIMESTAMP)
order by day desc