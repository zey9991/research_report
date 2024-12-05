with 
orders as (
  select * from query_3388490 -- gtrade.all.orders
)
,daily_users as (
  with daily_users as
  (
    select distinct date_trunc('day', block_time) as day,
      count(distinct trader) as daily_users
    from orders
    group by 1
  )
  ,users_time as
  (
    select trader, date_trunc('day', min(block_time)) as day
    from orders group by 1
  )
  ,new_users as
  (
    select day, count(trader) as new_users
    from users_time
    group by 1
  )
  ,cumulative_users as
  (
    select day, new_users,
      sum(new_users) over (order by day) as cumulative_users
    from new_users
  )
  select a.day, a.daily_users, coalesce(b.new_users, 0) as new_users,
    a.daily_users - coalesce(b.new_users, 0) as returned_users,
    if(b.cumulative_users is null, lag(b.cumulative_users, 1) over (order by a.day), b.cumulative_users) as cumulative_users
  from daily_users a left join cumulative_users b on a.day = b.day
)
select * from daily_users