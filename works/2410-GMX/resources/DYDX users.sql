WITH all_users AS (
    -- 获取所有交易账户及其最早交易日期
    SELECT 
        DATE_TRUNC('quarter', MIN(t.evt_block_time)) AS quarter,
        t."from" AS account
    FROM 
        erc20_ethereum.evt_Transfer AS t
    WHERE 
        t.contract_address = 0x92d6c1e31e14520e676a687f0a93788b716beff5
    GROUP BY 
        t."from"
    
    UNION

    SELECT 
        DATE_TRUNC('quarter', MIN(t.evt_block_time)) AS quarter,
        t."to" AS account
    FROM 
        erc20_ethereum.evt_Transfer AS t
    WHERE 
        t.contract_address = 0x92d6c1e31e14520e676a687f0a93788b716beff5
    GROUP BY 
        t."to"
),
first_transactions AS (
    -- 针对每个账户获取其最早的交易日期（即首次交易日）
    SELECT 
        account AS user,
        MIN(quarter) AS first_transaction_date
    FROM 
        all_users
    GROUP BY 
        account
),
quarterly_interactions AS (
    -- 每日活跃用户（quarterly_users），包括所有当天首次交互的账户
    SELECT 
        DATE_TRUNC('quarter', t.evt_block_time) AS quarter,
        t."from" AS account
    FROM 
        erc20_ethereum.evt_Transfer AS t
    WHERE 
        t.contract_address = 0x92d6c1e31e14520e676a687f0a93788b716beff5

    UNION

    SELECT 
        DATE_TRUNC('quarter', t.evt_block_time) AS quarter,
        t."to" AS account
    FROM 
        erc20_ethereum.evt_Transfer AS t
    WHERE 
        t.contract_address = 0x92d6c1e31e14520e676a687f0a93788b716beff5
),
quarterly_user_stats AS (
    -- 计算每日的活跃用户(quarterly_users)、新增用户(new_users)和累积用户(cumulative_users)
    SELECT 
        quarter,
        COUNT(DISTINCT account) AS quarterly_users,
        COUNT(DISTINCT CASE WHEN quarter = first_transaction_date THEN account END) AS new_users,
        SUM(COUNT(DISTINCT account)) OVER (ORDER BY quarter) AS cumulative_users
    FROM 
        quarterly_interactions di
    LEFT JOIN 
        first_transactions ft ON di.account = ft.user
    GROUP BY 
        quarter
),
final_stats AS (
    -- 计算每日旧用户数（old_users）
    SELECT 
        quarter,
        quarterly_users,
        new_users,
        cumulative_users,
        quarterly_users - new_users AS old_users
    FROM 
        quarterly_user_stats
)

-- 最终结果
SELECT * FROM final_stats
ORDER BY quarter;
