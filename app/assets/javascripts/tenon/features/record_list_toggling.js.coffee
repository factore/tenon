class Tenon.features.RecordListToggling
  constructor: ->
    $('body').on('click', '.enable-grid', @_switchToGrid)
    $('body').on('click', '.enable-list', @_switchToList)
    $('body').on('click', '.enable-grid, .enable-list', @_setActive)

  _switchToGrid: (e) ->
    $('.record-list').fadeOut 100, ->
      $(this)
        .removeClass('record-list')
        .addClass('record-grid')
        .fadeIn(100)
    $('.main-content').addClass('with-fixed-grid')

  _switchToList: (e) =>
    @_setActive($(e.currentTarget))
    $('.record-grid').fadeOut 100,  ->
      $(this)
        .removeClass('record-grid')
        .addClass('record-list')
        .fadeIn(100)
    $('.main-content').removeClass('with-fixed-grid')


  _setActive: (e) ->
    $(e.currentTarget)
      .addClass('active')
      .siblings().removeClass('active')
