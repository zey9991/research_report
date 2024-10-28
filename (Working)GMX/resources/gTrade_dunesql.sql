 with 
orders as (
  select * from query_3388490 -- gtrade.all.orders (all collaterals)
)
,daily_volume as
( 
  select date_trunc('day', block_time) as day, sum(pnl * collateralPriceUsd) as pnl, sum(pnl_raw * collateralPriceUsd) as pnl_before_fees,
         sum(if(group_name in ('crypto', 'altcoins'), position_size_dai * collateralPriceUsd * leverage, 0)) as crypto_volume,
         sum(if(group_name like 'forex%', position_size_dai * collateralPriceUsd * leverage, 0)) as forex_volume,
         sum(if(group_name = 'stocks', position_size_dai * collateralPriceUsd * leverage, 0)) as stocks_volume,
         sum(if(group_name = 'indices', position_size_dai * collateralPriceUsd * leverage, 0)) as indices_volume,
         sum(if(group_name = 'commodities', position_size_dai * collateralPriceUsd * leverage, 0)) as commodities_volume,
         sum(position_size_dai * collateralPriceUsd * leverage) as daily_volume,
         sum(if(collateral = 'DAI', position_size_dai * collateralPriceUsd * leverage, 0)) as dai_daily_volume,
         sum(if(collateral = 'USDC', position_size_dai * collateralPriceUsd * leverage, 0)) as usdc_daily_volume,
         sum(if(collateral = 'wETH', position_size_dai * collateralPriceUsd * leverage, 0)) as weth_daily_volume,
         sum(if(blockchain = 'polygon', position_size_dai * collateralPriceUsd * leverage, 0)) as polygon_daily_volume,
         sum(if(blockchain = 'arbitrum', position_size_dai * collateralPriceUsd * leverage, 0)) as arbitrum_daily_volume,
         sum(if(blockchain = 'base', position_size_dai * collateralPriceUsd * leverage, 0)) as base_daily_volume,
         sum(if("type" = 'LIQ', position_size_dai * collateralPriceUsd * leverage, 0)) as "liq_volume",
         sum(if("type" = 'LIQ', position_size_dai * collateralPriceUsd, 0)) as "liq_collateral",
         sum(if("type" = 'LIQ' and group_name in ('crypto', 'altcoins'), position_size_dai * collateralPriceUsd * leverage, 0)) as "crypto_liq_volume",
         sum(if("type" = 'LIQ' and group_name like 'forex%', position_size_dai * collateralPriceUsd * leverage, 0)) as "forex_liq_volume",
         sum(if("type" = 'LIQ' and group_name = 'stocks', position_size_dai * collateralPriceUsd * leverage, 0)) as "stocks_liq_volume",
         sum(if("type" = 'LIQ' and group_name = 'indices', position_size_dai * collateralPriceUsd * leverage, 0)) as "indices_liq_volume",
         sum(if("type" = 'LIQ' and group_name = 'commodities', position_size_dai * collateralPriceUsd * leverage, 0)) as "commodities_liq_volume",
         sum("project_fund" * collateralPriceUsd) as "project_fund",
         sum("dev_fund" * collateralPriceUsd) as "dev_fund",
         sum("referral" * collateralPriceUsd) as "referral",
         sum("nft_bots" * collateralPriceUsd) as "nft_bots",
         sum(if(collateral = 'DAI', "dai_stakers" * collateralPriceUsd, 0 )) as "dai_stakers",
         sum(if(collateral = 'USDC', "dai_stakers" * collateralPriceUsd, 0 )) as "usdc_stakers",
         sum(if(collateral = 'wETH', "dai_stakers" * collateralPriceUsd, 0 )) as "weth_stakers",
         sum("lp_stakers" * collateralPriceUsd) as "lp_stakers",
         sum("gns_stakers" * collateralPriceUsd) as "gns_stakers",
         sum(if(collateral = 'DAI', "gns_stakers" * collateralPriceUsd, 0 )) as "gns_stakers_dai",
          sum(if(collateral = 'USDC', "gns_stakers" * collateralPriceUsd, 0 )) as "gns_stakers_usdc",
          sum(if(collateral = 'wETH', "gns_stakers" * collateralPriceUsd, 0 )) as "gns_stakers_weth",
         -1 * sum(coalesce("rollover_fee", 0) * collateralPriceUsd) as "rollover_fee_neg",
         -1 * sum(coalesce("borrowing_fee", 0) * collateralPriceUsd) as "borrowing_fee_neg",
         sum(coalesce("rollover_fee", 0) * collateralPriceUsd) as "rollover_fee",
         sum(coalesce("borrowing_fee", 0) * collateralPriceUsd) as "borrowing_fee",
         sum(("project_fund" + "dev_fund" + "referral" + "nft_bots" + "dai_stakers" + "lp_stakers" + "gns_stakers")  * collateralPriceUsd) as "all_fees",
         count(*) as trades,
         avg(position_size_dai * collateralPriceUsd) as avg_margin_size,
         avg(leverage) as avg_leverage
  from orders
  group by 1
)
,open_positions as (
-- processing all orders except v9 orders (v9 orders --> increase/decrease trade)
  with open_orders as (
    select * from query_3388490 where ("type" = 'OPEN' or "type" = 'LIMIT') and version!='9'
  )
  , close_orders as (   
    select * from query_3388490 where "type" != 'OPEN' and "type" != 'LIMIT' and version!='9' 
  )
  , tmp1 as (
    select a.*, b."block_time" as "close_time"
    from open_orders a left join close_orders b
      on a."trader" = b."trader" and a."index" = b."index"
      and a."block_time" <= b."block_time" and a."leverage" = b."leverage"
      and a."pair_name" = b."pair_name" and a."open_price" = b."open_price"
      and a."long" = b."long" and a."position_size_dai" >= b."position_size_dai"
      and a.collateral = b.collateral and a.blockchain = b.blockchain
  )  
-- processing v9 orders: a) decrease orders --> volume*-1, type = 'OPEN' b) removing leverage, openPrice 
-- and positionSizeDai checks c)  matching with the correct close date
  , v9_orders as (   
    select * from query_3937748 
    union
    select * from query_3908328   
  ) 
  , tmp2 as (select a."block_time", a."group_name", a."pair_name", cast(a."long" as boolean) as long,
      a."position_size_dai" * a."leverage" * a.collateralPriceUsd as "volume",
      b."block_time" as "close_time"
    from v9_orders a left join close_orders b
      on a."trader" = b."trader" and a."index" = b."index"
      and a."block_time" <= b."block_time" and a."pair_name" = b."pair_name" 
      and a."long" = b."long" and a.collateral = b.collateral and a.blockchain = b.blockchain
  ),
-- Open orders with a partial update are not being matched correctly with a close date
    open_orders1 as (
    select * from query_3388490 where ("type" = 'OPEN' or "type" = 'LIMIT') and version!='9' 
    and block_time >cast('2024-06-01 00:00' as TIMESTAMP)
  )
  , close_orders1 as (   
    select * from query_3388490 where "type" != 'OPEN' and "type" != 'LIMIT' and version!='9' 
    and block_time >cast('2024-06-01 00:00' as TIMESTAMP)    
  )
  , tmp3 as (
    select a.*, b."block_time" as "close_time"
    from open_orders1 a inner join close_orders1 b
      on a."trader" = b."trader" and a."index" = b."index"
      and a."block_time" <= b."block_time" 
      and a."pair_name" = b."pair_name" and a."long" = b."long"
      and a.collateral = b.collateral and a.blockchain = b.blockchain
      and not (a.position_size_dai >= b.position_size_dai and a.leverage=b.leverage 
    and a.open_price=b.open_price)
  )
  , tmp4 as (
    select a."block_time", a."group_name", a."pair_name", cast(a."long" as boolean) as long,
      a."position_size_dai" * a."leverage" * a.collateralPriceUsd as "volume",
      coalesce(a."close_time", b."close_time", cast(null as timestamp)) as "close_time"
      from tmp1 a left join tmp3 b
      on a."trader" = b."trader" and a."index" = b."index"
      and a."block_time" = b."block_time" 
      and a."pair_name" = b."pair_name" and a."long" = b."long"
      and a.collateral = b.collateral and a.blockchain = b.blockchain
  )
  -- union all three results
  , tmp as (
    select * from tmp2
    union all 
    select * from tmp4
  )
  , days as (
    select * from UNNEST(sequence(date('2021-10-14'), date(cast(now() as timestamp)), interval '1' day)) as day(day)
  )
  select a."day",
    sum(case "long" when true then "volume" else 0 end) as "long",
    sum(case "long" when false then "volume" else 0 end) as "short",
    sum(if(group_name in ('crypto', 'altcoins'), volume, 0)) as crypto_oi,
    sum(if(group_name like 'forex%', volume, 0)) as forex_oi,
    sum(if(group_name = 'stocks', volume, 0)) as stocks_oi,
    sum(if(group_name = 'indices', volume, 0)) as indices_oi,
    sum(if(group_name = 'commodities', volume, 0)) as commodities_oi
  from days a left join tmp b
    on date_trunc('day', b."block_time") <= a."day"
      and (date_trunc('day', b."close_time") > a."day" or b."close_time" is null)
  group by 1
  order by 1
)
,daily_users as (
    select * from dune.gains.result_subquery_g_tade_stats_users_table -- @todo v7
)
,daily_stats as (
  select a.*, b.long + b.short as open_interests,
       b.crypto_oi, b.forex_oi, b.stocks_oi, b.indices_oi, b.commodities_oi,
       avg(daily_volume) OVER (ORDER BY a.day ROWS BETWEEN 6 PRECEDING AND 0 FOLLOWING) AS "7 Days Moving Average",
       avg(daily_volume) OVER (ORDER BY a.day ROWS BETWEEN 29 PRECEDING AND 0 FOLLOWING) AS "30 Days Moving Average",
       sum(daily_volume) OVER (ORDER BY a.day) AS "Cumulative Volume",
       sum(pnl) over (order by a.day) as cumulative_pnl,
       sum(pnl_before_fees) over (order by a.day) as cumulative_pnl_before_fees,
       sum("project_fund") over (order by a."day") as "cumulative project_fund",
       sum("dev_fund") over (order by a."day") as "cumulative dev_fund",
       sum("referral") over (order by a."day") as "cumulative referral",
       sum("nft_bots") over (order by a."day") as "cumulative nft_bots",
       sum("dai_stakers") over (order by a."day") as "cumulative dai_stakers",
       sum("lp_stakers") over (order by a."day") as "cumulative lp_stakers",
       sum("gns_stakers") over (order by a."day") as "cumulative gns_stakers",
       sum("rollover_fee") over (order by a."day") as "cumulative rollover_fee",
       sum("borrowing_fee") over (order by a."day") as "cumulative borrowing_fee",
       sum("all_fees") over (order by a."day") as "cumulative all_fees",
              avg(all_fees) OVER (ORDER BY a.day ROWS BETWEEN 6 PRECEDING AND 0 FOLLOWING) AS "7D MA Fees",
       avg(all_fees) OVER (ORDER BY a.day ROWS BETWEEN 29 PRECEDING AND 0 FOLLOWING) AS "30D MA Fees",
       sum(trades) over (order by a.day) as cumulative_trades,
       avg(c.daily_users) OVER (ORDER BY a.day ROWS BETWEEN 29 PRECEDING AND 0 FOLLOWING) AS "30d-ma Traders",
       c.daily_users, c.new_users, c.returned_users, c.cumulative_users
  from daily_volume a left join open_positions b on a.day = b.day
    left join daily_users c on a.day = c.day
)

select * from daily_stats
where day >=  cast( '{{start_date}}' as TIMESTAMP)
order by day desc 