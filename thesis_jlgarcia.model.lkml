connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

explore: accidents {
  group_label: "TSR Thesis - JL"
  label: "Accidents"
  join: carriers {
    relationship: many_to_one
    sql_on: ${accidents.air_carrier} = ${carriers.name} ;;
  }
  join: airports {
    relationship: many_to_one
    sql_on: ${airports.code} = ${accidents.airport_code} ;;
  }
}

explore: aircraft {
  group_label: "TSR Thesis - JL"
  label: "Aircrafts"
}

explore: aircraft_models {}

explore: airports {}

explore: carriers {}

explore: flights {
  group_label: "TSR Thesis - JL"
  label: "Flights"
  join: airports {
    relationship: many_to_one
    sql_on: ${airports.code} = ${flights.origin} ;;
  }
  join: carriers {
    relationship: many_to_one
    sql_on: ${carriers.code} = ${flights.carrier} ;;
  }
  join: delayed_fligths_location {
    relationship: many_to_one
    sql_on: ${delayed_fligths_location.origin} = ${airports.code} ;;
  }
}

explore: flights_by_day {}
