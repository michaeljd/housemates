# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($) ->
  
  # Load Google visualization library if a chart element exists
  if $("[data-chart]").length > 0
    $.getScript "https://www.google.com/jsapi", (data, textStatus) ->
      google.load "visualization", "1.0",
        packages: ["corechart"]
        callback: ->
          
          # Google visualization library loaded
          $("[data-chart]").each ->
            div = $(this)
            
            # Fetch chart data
            $.getJSON div.data("chart"), (data) ->
              
              # Draw the chart
              chart = new google.visualization.ChartWrapper()
              chart.setChartType data.type
              chart.setDataTable new google.visualization.DataTable(data.table)
              chart.setOptions data.options
              chart.setOption "width", div.width()
              chart.setOption "height", div.height()
              chart.draw div.get(0)
