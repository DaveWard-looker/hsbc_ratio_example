view: ratio_data {
  sql_table_name: `daveward-ps-dev.daveward_demodataset.ratio_data`
    ;;

  dimension: amount {
    type: number
    sql: ${TABLE}.Amount ;;
  }

  dimension: business_group {
    type: string
    sql: ${TABLE}.Business_Group ;;
  }

  dimension: metric_id {
    type: number
    sql: ${TABLE}.Metric_ID ;;
  }

  dimension: metric_name {
    type: string
    sql: ${TABLE}.Metric_Name ;;
  }

  dimension_group: period {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.Period;;
  }

  dimension: date_field {
    type: string
    sql: CAST(${period_date} as string) ;;
  }

  dimension_group: previous_period {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.Period;;
  }

  measure: count {
    type: count
    drill_fields: [metric_name]
  }
}
