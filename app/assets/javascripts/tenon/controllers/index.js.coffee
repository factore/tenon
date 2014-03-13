Tenon.dispatcher.route 'tenon/index#index', ->
  # Set the callout heights
  heights = _.map($('.callout .callout-content'), (c) -> $(c).outerHeight())
  height = Math.max.apply(Math, heights)
  $('.callout .callout-content').css('min-height', height)