pad = (n, width, z) ->
  z = z || '0'
  n = n + ''
  if n.length >= width then n else new Array(width - n.length + 1).join(z) + n

timeUnit = (millisPerUnit, cap = Infinity) ->
  format: (time) ->
    pad(parseInt((time / millisPerUnit) % cap), 2)

UNITS =
  Second : timeUnit(1000, 60)
  Minute : timeUnit(1000 * 60, 60)
  Hour : timeUnit(1000 * 60 * 60, 24)
  Day : timeUnit(1000 * 60 * 60 * 24)

ORDERED_UNITS = [UNITS.Hour, UNITS.Minute, UNITS.Second]

class CountdownModel
  constructor: (@date) ->

  remainingTime: ->
    Math.max(@date.getTime() - new Date().getTime(), 0)

  format: (remaining)->
    time = (unit.format(remaining) for unit in ORDERED_UNITS).join(':')
    days = UNITS.Day.format(remaining)
    (if days > 0 then "#{days} días - " else "") + time

  formatted: ->
    this.format(this.remainingTime())

class CountdownView
  constructor: (element, @model) ->
    @$element = $(element)
    this.update()
    this.startTimeout()

  update: ->
    @$element.text(@model.formatted())

  startTimeout: ->
    setInterval(=>
      this.update()
    , 500)

window.Countdown =
  createOn: (element, date) ->
    new CountdownView(element, new CountdownModel(date))
