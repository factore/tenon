Tenon.dispatcher.route 'tenon/index#index', ->
  # Set the callout heights
  $el = $('.callout')
  heights = _.map($el, (c) -> $(c).outerHeight())
  height = Math.max.apply(Math, heights)# + 48
  $el.css('min-height', height)
