view: expected_results {
  derived_table: {
    sql: with cte as (
      SELECT
            2 as metric_id,
            'AD Ratio' as metric_name,
            Sum(case when metric_id = 312 then Amount else 0 end)/nullif(Sum(case when metric_id = 123 then Amount else 0 end),0) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            union all
            SELECT
            355 as metric_id,
            'nii_for_wpb' as metric_name,
            Sum(case when metric_id = 373  and business_group = 'WPB 'then Amount else 0 end) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            where 1=1
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            union all
            SELECT
            310 as metric_id,
            'JAWs' as metric_name,
            (SUM(case when metric_id = 801 and EXTRACT(DATE FROM period) = {% parameter current_period %} then Amount else 0 end)) -((SUM(case when metric_id = 801 and period = {% parameter comparison_period %} then Amount else 0 end))/(SUM(case when metric_id = 801 and EXTRACT(DATE FROM period) = {% parameter comparison_period %} then Amount else 0 end))) /
            (SUM(case when metric_id = 403 and EXTRACT(DATE FROM period) = {% parameter current_period %} then Amount else 0 end)) -((SUM(case when metric_id = 403 and period = {% parameter comparison_period %} then Amount else 0 end))/(SUM(case when metric_id = 403 and EXTRACT(DATE FROM period) = {% parameter comparison_period %} then Amount else 0 end)))
            as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            UNION ALL
            SELECT
            123 as metric_id,
            'Deposit' as metric_name,
            Sum(case when metric_id = 123 then Amount else 0 end) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            UNION ALL
            SELECT
            312 as metric_id,
            'Loan' as metric_name,
            Sum(case when metric_id = 312 then Amount else 0 end) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            UNION ALL
            SELECT
            373 as metric_id,
            'NII' as metric_name,
            Sum(case when metric_id = 373 then Amount else 0 end) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            UNION ALL
            SELECT
            403 as metric_id,
            'Expenses' as metric_name,
            Sum(case when metric_id = 403 then Amount else 0 end) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            UNION ALL
            SELECT
            801 as metric_id,
            'Revenue' as metric_name,
            Sum(case when metric_id = 801 then Amount else 0 end) as amount
            FROM `daveward-ps-dev.daveward_demodataset.ratio_data` rd
            WHERE 1=1
            and {% condition business_group %} rd.business_group {% endcondition %}
            and {% condition current_period %} EXTRACT(DATE FROM rd.period) {% endcondition %}
            )
            select
            metric_id,
            metric_name,
            sum(amount) as amount
             from cte
             group by 1,2
       ;;
  }

  filter: current_period {
    type: string
    suggest_explore: ratio_data
    suggest_dimension: ratio_data.date_field
  }

  filter: comparison_period {
    type: string
    suggest_explore: ratio_data
    suggest_dimension: ratio_data.date_field
  }

  filter: business_group {
    type: string
    suggest_explore: ratio_data
    suggest_dimension: business_group
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: metric_id {
    type: number
    sql: ${TABLE}.metric_id ;;
  }

  dimension: metric_name {
    type: string
    sql: ${TABLE}.metric_name ;;
  }

  dimension: amount {
    hidden: yes
    type: number
    sql: ${TABLE}.amount ;;
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
  }

  measure: average_amount {
    type: average
    sql: ${amount} ;;
  }

  measure: max_amount {
    type: max
  sql: ${amount} ;;
  }

  measure: median_amount {
    type: median
    sql: ${amount} ;;
  }

  measure: min_amount {
    type: min
    sql: ${amount} ;;
  }

  set: detail {
    fields: [metric_id, metric_name, amount]
  }
}
