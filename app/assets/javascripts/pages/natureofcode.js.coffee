window.hs ||= {}
hs.pages ||= {}
hs.pages.natureofcode = {
  init: ->
    setupCanvas()
    canvas = document.getElementById 'processing'
    window.p = new Processing canvas, initialize
}

setupCanvas = ->
  $canvas = $('#processing')
  $canvas.css({
    width: $canvas.parent().width()
    height: 500
  })

initialize = (p = {}) ->
  color = 0
  x = 0
  y = 0
  vel_x = 4
  vel_y = 10.3
  $canvas = $('#processing')
  p.setup = ->
    p.size $canvas.width(), $canvas.height()
    p.background 255

  p.draw  = ->
    color++
    if color > 360 then color = 0
    # p.background( 255 )
    x += p.random vel_x
    y += p.random vel_y
    if 0 > x || x > p.width
      vel_x = vel_x * -1

    if 0 > y || y > p.height
      vel_y = vel_y * -1

    p.colorMode(p.HSB, 360, 100, 100, 100)
    p.fill p.color( color, p.random(100), 100, 100 )
    p.colorMode 1, 255
    p.stroke 0

    p.ellipse x, y, 16, 16

class PVector
  constructor: (x = 0, y = 0) ->
    @x = x
    @y = y
    @

  add: (vector) ->
    @x += vector.x
    @y += vector.y
    @
  
