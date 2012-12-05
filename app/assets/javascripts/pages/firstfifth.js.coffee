hs = window.hs
hs.pages.firstfifth = {
  init: () ->
    console.log "init"
    height = 300
    width = $('.well').width()
    i = 100

    data = [29.5,20.4,16.5,12,9.2,6.8,5.9]

    radius = d3.scale.linear()
      .domain([0, 1])
      .range([5,15])

    angle = d3.scale.linear()
      .domain([0, data.length])
      .range([0, 2 * Math.PI]);

    radialSvg = d3.select('.well')
      .append('svg')
      .attr('class', 'radial')
      .attr('height', 600)

    
    rLine = d3.svg.line.radial()
      .radius((d) -> radius(d))
      .angle (d, i) -> angle(i)

    data = data.sort()

    group = radialSvg.append('g')
      .attr('transform', "translate(#{width/2}, #{300})")
      .append('g')
      .attr('transform', 'rotate(0)')

    path = group.append('path')
      .data([data])
      ###
      .attr('class', 'shape')
      .attr('fill', "hsla(#{i},50%,50%,.75)")
      .attr('d', rLine)
      .attr('opacity', 0)
      .transition()
      .duration(6000)
      .attr('opacity', 0)
      .each('end', -> d3.select(this).remove())
      ###
    radialSvg.append('path')
      .attr('d', 'M244.791,46.037v213.889c0,0.094,0.05,0.164,0.066,0.249v0.785c0,5.187,3.538,11.315,10.017,11.315h49.748 c25.525,0,39.093,16.149,39.093,36.181c0,20.368-15.517,38.14-37.479,38.14c-21.647,0-40.383-16.807-41.686-18.099 c-2.591-2.27-5.494-1.614-7.751,0.327l-16.158,15.829c-3.875,3.871-3.548,6.138,0.652,10.989 c8.077,9.698,29.071,26.808,63.651,26.808c44.578,0,78.178-33.599,78.178-73.994c0-42.31-28.092-71.72-73.98-71.72h-22.339v-58.549 h79.793c3.233,0,6.144-2.922,6.144-6.138V145.56c0-3.245-2.91-6.149-6.144-6.149h-79.793V78.666h90.227 c3.548,0,6.134-2.907,6.134-6.142V46.037c0-3.236-2.586-6.136-6.134-6.136H250.932C247.375,39.9,244.791,42.801,244.791,46.037z')
      .attr('fill', '#f5f5f5')
      .attr('transform', "translate(#{(width/2) - 250}, 150), scale(.8)")

    window.draw = ->
      i -= 5
      if i < 0
        i = 360
      val = data.shift()
      data.push(val)
      data = _(data).shuffle()
      prevPath = path
      path = group.append('path')

      #path
      #  .data([data])
      #  .transition()
      #  .duration(6000)
      #  .attr('fill', "hsl(#{index * 360},#{index * 50 + 25}%,#{index * 50 + 25}%)")
      #  .attr('d', rLine)
      #  .each('end', draw)

      path
        .data([data])
        .attr('opacity', 0)
        .attr('fill', prevPath.attr('fill'))
        .attr('d', prevPath.attr('d'))
        .attr('transform', prevPath.attr('transform'))
        .transition()
        .duration(6000)
        .ease('linear')
        .attr('opacity', 1)
        .attr('transform', "rotate(#{Math.random() * 360})")
        .transition()
        .duration(6000)
        .attr('fill', "hsla(#{i},50%,50%, .75)")
        .attr('d', rLine)
        .each('end', draw)
        .transition()
        .delay(6000)
        .duration(12000)
        .attr('opacity', 0)
        .each('end', => d3.select(this).remove())

    draw()

    f5 = d3.select '#f5'

    f5.attr 'height', height
    f5.attr 'width', width
    
    f5.remove()

    pg = d3.select('#polygon')
    map = d3.select('#map').remove()
    contenents = map.selectAll('g')
    contenents.attr('fill-opacity', 1)
      .transition().duration(10000)
      .attr 'fill-opacity', (d, i) -> 1 / (i + 1)

    rotation = 0

    rotate = ->
      rotation += .25
      pg.attr('transform', "rotate(#{rotation} #{width/2 - 150} 175)")
        .attr('fill', "hsl(#{rotation}, 50%, 50%)")

      rotation >= 360

    pg.attr('transform', "rotate(#{rotation} #{width/2} 175)")
      .attr('fill', "hsl(#{rotation}, 50%, 50%)")

    d3.timer(rotate)
}
