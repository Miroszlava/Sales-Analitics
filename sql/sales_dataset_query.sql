SELECT
  s.date AS order_date,
  o.ga_session_id,
  o.item_id,

  sp.continent,
  sp.country,

  sp.device,
  sp.mobile_model_name,
  sp.operating_system,
  sp.language,
  sp.browser,

  sp.medium AS traffic_source,
  sp.channel AS traffic_channel,

  p.category,
  p.name AS product_name,
  p.price,
  p.short_description,

  a.id AS user_id,
  CAST(a.is_verified AS INT64) AS email_confirmed,
  CASE 
    WHEN a.is_unsubscribed = 1 THEN 0 
    ELSE 1 
  END AS is_subscribed

FROM `data-analytics-mate.DA.order` o

LEFT JOIN `data-analytics-mate.DA.session` s
  ON o.ga_session_id = s.ga_session_id

LEFT JOIN `data-analytics-mate.DA.session_params` sp
  ON o.ga_session_id = sp.ga_session_id

LEFT JOIN `data-analytics-mate.DA.product` p
  ON o.item_id = p.item_id

LEFT JOIN `data-analytics-mate.DA.account_session` acs
  ON o.ga_session_id = acs.ga_session_id

LEFT JOIN `data-analytics-mate.DA.account` a
  ON acs.account_id = a.id;
