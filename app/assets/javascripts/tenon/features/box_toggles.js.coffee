class Tenon.features.BoxToggles
  constructor: ->
    $.each($('.box .header'), @_addToggleButtons)
    $('.box .header').on('click', '.toggle-box', @_toggle)

  _addToggleButtons: ->
    $header = $(this)
    $angles = [
      $('<i />').addClass('fa fa-angle-down'),
      $('<i />').addClass('fa fa-angle-up')
    ]
    $link = $('<a />').html($angles).addClass('box-action toggle-box')
    $link.appendTo($header)

  _toggle: (e) ->
    $link = $(e.currentTarget)
    $link.closest('.box').toggleClass('closed')