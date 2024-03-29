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
    height: 1100
  })

initialize = (p = {}) ->
  $canvas = $('#processing')
  movers = []

  p.PVector.add = (v1, v2) ->
      return new p.PVector(v1.x + v2.x, v1.y + v2.y)
  p.PVector.sub = (v1, v2) ->
      return new p.PVector(v1.x - v2.x, v1.y - v2.y)
  
  p.setup = ->
    p.size $canvas.width(), $canvas.height()
    p.background 0

    for y in [1..30]
      for x in [1..50]
        origin_y = (p.height / 30) * y
        origin_x = (p.width / 50) * x
        movers.push new Mover(p, {x: origin_x, y: origin_y})

  p.draw  = ->
    p.colorMode p.RGB, 255, 255, 255, 100
    p.fill 0, 0, 0, 5
    p.stroke 0,0,0,0
    p.rect 0, 0, p.width, p.height
    #p.background 255
    #if p.frameCount % 5 == 0
    #  movers.push new Mover(p)
    flagged = []
    for mover, i in movers
      mover.update()
      mover.display()
      #if mover.checkEdges()
      #  flagged.push(i)
    for mover in flagged
      movers.splice(mover, 1)

class Mover

  constructor: (@p, options) ->
    @origin = new @p.PVector options.x, options.y
    @velocity = new @p.PVector 0,0
    @forces = []
    offsetx = @p.width / 2
    offsety = @p.height / 2
    #x = if (options.x >= offsetx) then offsetx else offsetx * -1
    #y = if (options.y >= offsety) then offsety else offsety * -1
    @location = new @p.PVector options.x, options.y

  update: ->
    mouse = new p.PVector(p.mouseX, p.mouseY)
    @forces.gravity = p.PVector.sub @origin, @location
    @forces.gravity.mult .001
    @forces.direction = p.PVector.sub mouse, @location
    @forces.direction.normalize()
    @forces.direction.mult .001 * ((@p.frameCount % 1000) - 250)
    accelleration = new p.PVector(0,0)

    for name, force of @forces
      accelleration.add force

    @velocity.add accelleration
    @velocity.limit(5)

    @location.add @velocity

    @color = (@velocity.mag() * 10) % 360

  display: ->
    @p.colorMode @p.HSB, 360, 100, 100, 100
    @p.stroke(@color, 100, 50, 100)
    @p.fill(@color, 100, 50, 100)
    radius = @velocity.mag() * 2
    @p.ellipse @location.x, @location.y, radius, radius

  checkEdges: ->
    if @location.x > @p.width || @location.x < 0 || @location.y > @p.height || @location.y < 0
      return true
    else
      return false

