window.hs ||= {}
hs.pages ||= {}
hs.pages.natureofcode1 = {
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
  location = new p.PVector(100, 100)
  velocity = new p.PVector(2.5, 5)
  $canvas = $('#processing')

  p.setup = ->
    p.size $canvas.width(), $canvas.height()
    p.background 255

  p.draw  = ->
    p.background( 255 )
    location.add(velocity)

    if 0 > location.x || location.x > p.width
      velocity.x = velocity.x * -1

    if 0 > location.y || location.y > p.height
      velocity.y = velocity.y * -1

    p.fill 175
    p.stroke 0

    p.ellipse location.x, location.y, 16, 16
###
class PVector
  constructor: (x = 0, y = 0) ->
    @x = x
    @y = y
    @

  add: (vector) ->
    @x += vector.x
    @y += vector.y
    @
  
