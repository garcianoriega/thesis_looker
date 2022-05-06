# If necessary, uncomment the line below to include explore_source.
# include: "thesis_jlgarcia.model.lkml"

view: delayed_fligths_location {
  derived_table: {
    explore_source: flights {
      column: city { field: airports.city }
      column: dep_delay {}
      column: origin {}
      column: count {}
    }
  }
  dimension: city {
    description: ""
  }
  dimension: origin {
    description: ""
    html: {% if value == 'LAX' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'ATL' %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }
  dimension: city_image {
    sql: ${airports.city} ;;
    html: <img src="http://www.brettcase.com/product_images/{{ value }}.jpg" /> ;;
  }
  measure: Dep_Delayed {
    type: count
    filters: {
      field: flights.dep_delay
      value: "> 0"
    }
    #drill_fields: [carriers.name, dep_quarter, count]
  }
}
