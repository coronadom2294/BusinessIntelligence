#$ ->
#  alert('foo')

data = undefined

path = d3.geo.path()

svg = d3.select("#chart").append("svg")

districts = svg.append("g").attr("id", "districts").attr("class", "Blues")

states = svg.append("g").attr("id", "states")

d3.json "/json/us-states.json", (json) ->
  states.selectAll("path").data(json.features).enter().append("path").attr "d", path
  states.selectAll("path").attr("class", "Blues")

d3.json "/json/short_districts.json", (json) ->
  data = json;
  console.log(json);
  districts.selectAll("path").data(json.features).enter().append("path").attr("class", (if data then quantize else null)).attr("d", path).on("mouseover", (d) ->
        $.ajax 'http://services.sunlightlabs.com/api/legislators.get.json?apikey=bcd59523ca7c46a2a8dce3acaeccad75&district=8&state=OH?callback=?', (json) ->
                $("#details").html(json.legislator.lastname)
        d3.select(this).style('fill', 'red');
  ).on("mouseout", (d) ->
        d3.select(this).style('fill', 'green');
  )


quantize = (d) ->
  "q" + Math.min(8, d.properties.color_index) + "-9"