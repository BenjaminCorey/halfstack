window.hs ||= {}
hs.pages ||= {}
hs.pages.processing = {
  init: ->
    setupCanvas()
    initialize()
}

setupCanvas = ->
  $canvas = $('#processing')
  $canvas.css({
    width: '100%'
    height: 700
  })

draw = (p5 = {}) ->
  p5.setup = () ->
    width = $('#processing').width()
    height = 700
    p5.size(width, height)
    p5.background 245
    @beans = []
    window.beans = @beans
  p5.draw = () ->
    p5.fill(245,245,245,.01)
    p5.noStroke()
    p5.rect(0,0,p5.width, p5.height)
    xOffset = p5.frameCount * .0005
    yOffset = xOffset + 20
    x = p5.noise(xOffset) * p5.width
    y = p5.noise(yOffset) * p5.height

    #p5.stroke(255, 0, 0, 15)
    #p5.point(x, y)
    if p5.frameCount % 8 == 0
      bean = new Bean(p5, {
        x: x
        y: y
        xOffset: xOffset
        yOffset: yOffset
      })
      @beans.push(bean)

    bean.draw() for bean in @beans

    # if p5.frameCount % 20 == 0
    #   @beans.splice(parseInt(Math.random() * @beans.length), 1)

class Bean
  constructor: (@p5, options) ->
    @x = options.x
    @y = options.y

    @xOffset = options.xOffset
    @yOffset = options.yOffset

    @velocity = options.velocity || 3
    @accelleration = options.accelleration || 0.003

  draw: () ->
    return unless @velocity > 0
    @xOffset += .0007
    @yOffset += .0007

    @velocity += @accelleration

    @x += @p5.noise(@xOffset) * @velocity - @velocity/2
    @y += @p5.noise(@yOffset) * @velocity - @velocity/2

    @setColor()
    @p5.point(@x, @y)

  setColor: () ->
    @p5.colorMode @p5.HSB, 360, 100, 100
    h = @p5.noise ((@xOffset + @yOffset) / 2) * 360
    s = 100
    b = 100
    a = 10

    @p5.stroke(h,s,b,a)

initialize = ->  
  $ ->
    canvas = document.getElementById "processing"
    processing = new Processing canvas, draw