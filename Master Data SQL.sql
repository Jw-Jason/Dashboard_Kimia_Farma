select
  kft.transaction_id,
  kft.date,
  kft.branch_id,
  kkc.branch_name,
  kkc.kota,
  kkc.provinsi,
  kkc.rating as rating_cabang,
  kft.customer_name,
  kft.product_id,
  kp.product_name,
  kft.price,
  kft.discount_percentage,
  case
    when kft.price <= 50000 then 0.1
    when kft.price between 50001 and 100000 then 0.15
    when kft.price between 100001 and 300000 then 0.2
    when kft.price between 300001 and 500000 then 0.25
    when kft.price > 500000 then 0.3
    else 0
  end as persentase_gross_laba,
  kft.price - (kft.price * kft.discount_percentage) as nett_sales,
  (case
    when kft.price <= 50000 then 0.1
    when kft.price between 50001 and 100000 then 0.15
    when kft.price between 100001 and 300000 then 0.2
    when kft.price between 300001 and 500000 then 0.25
    when kft.price > 500000 then 0.3
    else 0
  end) * (kft.price - (kft.price * kft.discount_percentage)) as nett_profit,
  kft.rating
from
  `kimiafarma_dataset.kf_final_transaction` as kft
left join `kimiafarma_dataset.kf_kantor_cabang` as kkc
  on kft.branch_id = kkc.branch_id
left join `kimiafarma_dataset.kf_product` as kp
  on kft.product_id = kp.product_id
