connection: "bigquery_personal_instance"

# include all the views
include: "/views/**/*.view"

datagroup: ratio_demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ratio_demo_default_datagroup

explore: ratio_data {
  hidden: yes
}


explore: expected_results {}
