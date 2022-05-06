view: flights {
  sql_table_name: faa.flights ;;

  filter: carrier_select {
    suggest_dimension: carriers.name
  }

  dimension: carrier_comparitor {
    type: string
    sql:
    CASE
      WHEN {% condition carrier_select %} carriers.name {% endcondition %}
        THEN ${carriers.name}
      ELSE 'Rest of Carriers'
    END ;;
  }
  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }

  dimension_group: arr {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }

  dimension_group: dep {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.dep_time ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
    link: {
      label: "Explore {{ value }}"
      url: "/dashboards/344?Origin%20Airport={{ value }}&Origin%20State={{ _filters['airports.state'] | url_encode }}&Carrier%20Name={{ _filters['carriers.name'] | url_encode }}"
    }
  }

  dimension: tail_num {
    type: string
    sql: ${TABLE}.tail_num ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: Not_Cancelled {
    type: count
    filters: {
      field: cancelled
      value: "N"
    }
    drill_fields: [carriers.name, Dep_Delayed, Dep_Not_Delayed]
  }
  measure: Flights_Cancelled {
    type: count
    filters: {
      field: cancelled
      value: "Y"
    }
    drill_fields: [carriers.name, count, arr_quarter]
  }

  measure: Cancelled_Carrier {
    type: count
    filters: {
      field:  cancelled
      value: "Y"
    }
    drill_fields: [airports.full_name, count, arr_quarter]
  }

  measure: Not_Cancelled_Carrier {
    type:  count
    filters: {
      field: cancelled
      value: "N"
    }
    drill_fields: [airports.full_name, Dep_Delayed, Dep_Not_Delayed]
  }

  measure: Dep_Delayed {
    type: count
    filters: {
      field: dep_delay
      value: "> 0"
    }
    drill_fields: [carriers.name, dep_quarter, count]
  }
  measure: Dep_Not_Delayed {
    type: count
    filters: {
      field: dep_delay
      value: "<= 0"
    }
    drill_fields: [carriers.name, dep_quarter, count]
  }

  measure: Arr_Delayed {
    type: count
    filters: {
      field: arr_delay
      value: "> 0"
    }
    drill_fields: [diverted, count, airports.full_name]
  }
  measure: Arr_Not_Delayed {
    type: count
    filters: {
      field: arr_delay
      value: "<= 0"
    }
  }

  measure: Average_Departure_Delay{
    type: average
    sql: ${flights.dep_delay} ;;
  }

  measure: Average_Arrival_Delay{
    type: average
    sql: ${flights.arr_delay} ;;
  }
}
