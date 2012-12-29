hs = window.hs
hs.pages ||= {}
hs.pages.grid = {}
hs.pages.grid.init = ->
  ###
  data = []
  i = 1
  j = 1
  while i < 60
    while j < 117
      data.push [i * 10, j * 10]
      j++
    i++
    j = 1
  console.log data

  svg = d3.select('.well').append('svg')
    .attr('width', $('.well').width())
    .attr('height', 600)
  window.color = d3.scale.linear()
    .range(['blue', 'red'])
    .domain [0, data.length]

  svg.selectAll('.dot')
    .data(data)
    .enter()
    .append('circle')
    .attr('class', 'dot')
    .attr('cx', (d) -> d[1])
    .attr('cy', (d) -> d[0])
    .attr('r', 2)
    .attr('fill', (d, i) -> color(i))
  ###

  svg = d3.select('.well').append('svg')
    .attr('width', $('.well').width())
    .attr('height', 600)

  circle = svg.append('circle')
    .datum([1, 1])
    .attr('class', 'dot')
    .attr('cx', (d) -> d[1])
    .attr('cy', (d) -> d[0])
    .attr('r', 10)

  animate = ->

    if 0 > +circle.attr('cx') || +circle.attr('cx') > +svg.attr('width')
      console.log 'reverse'
      circle.datum( (d) -> [-d[0], d[1]] )
    if 0 > +circle.attr('cy') || +circle.attr('cy') > +svg.attr('height')
      console.log 'reverse'
      circle.datum( (d) -> [d[0], -d[1]] )

    circle.transition()
      .duration(10)
      .ease('linear')
      .attr('cx', (d) -> +d3.select(@).attr('cx') + d[0])
      .attr('cy', (d) -> +d3.select(@).attr('cy') + d[1])
      .each('end',animate)

  d3.timer  animate()
