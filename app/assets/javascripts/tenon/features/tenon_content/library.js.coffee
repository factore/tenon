class Tenon.features.tenonContent.Library
  constructor: (@$link, @$el, @$template) ->
    @_setContext()
    @$el.find('a.add_fields').on('click', @_closeModal )
    $('a.add_fields').hover(
      ->
        $(this).find('img').attr 'src', '/assets/tenon/tenon-content/' + $(this).find('img').data('row-type') + '_hover.png'
      , ->
        $(this).find('img').attr 'src', '/assets/tenon/tenon-content/' + $(this).find('img').data('row-type') + '.png'
    )

  _closeModal: => Tenon.features.ModalWindows.closeModals()

  _setContext: =>
    if @$link.hasClass('initial-row')
      @_setToInsertInitialRow()
    else if @$link.is('[data-tn-tc-insert]')
      @_setToInsertRelative()
    else
      @_setToInsertByData()

  _setToInsertInitialRow: =>
    node = @$link.closest('.tn-tc').find('.tn-tc__rows')
    $('.tn-tc-library a').data('association-insertion-node', node)
    $('.tn-tc-library a').data('association-insertion-method', 'append')

  _setToInsertByData: =>
    datas = [
      'association-insertion-node',
      'association-insertion-method',
      'association-insertion-traversal'
    ]
    for data in datas
      $('.tn-tc-library a').data(data, @$link.data(data))

  _setToInsertRelative: =>
    method = @$link.data('tn-tc-insert')
    console.log(method)
    $('.tn-tc-library a').data('association-insertion-node', @$link.closest('.tn-tc-row'))
    $('.tn-tc-library a').data('association-insertion-method', method)
