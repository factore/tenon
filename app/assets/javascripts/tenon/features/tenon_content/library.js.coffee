class Tenon.features.tenonContent.Library
  constructor: (@$link, @$el, @$template) ->
    @_setContext()
    @$el.find('a.add_fields').on('click', @_closeModal )
    $('a.add_fields').hover(
      ->
        $(this).find('img').attr 'src', '/assets/tenon/tenon-content/' + $(this).find('img').data('row-type') + '_hover.png'
      , ->
        $(this).find('img').attr 'src', '/assets/tenon/tenon-content/' + $(this).find('img').data('row-type') + '.png'
    );

  _closeModal: => @$template.modal('hide')

  _setContext: =>
    if @$link.hasClass('initial-row')
      @_setToInsertInitialRow()
    else if @$link.hasClass('above') || @$link.hasClass('below')
      @_setToInsertRelative()
    else
      @_setToInsertByData()

  _setToInsertInitialRow: =>
    node = @$link.closest('.tn-tc').find('.tenon-content')
    $('.tenon-library a').data('association-insertion-node', node)
    $('.tenon-library a').data('association-insertion-method', 'prepend')

  _setToInsertByData: =>
    datas = [
      'association-insertion-node',
      'association-insertion-method',
      'association-insertion-traversal'
    ]
    for data in datas
      $('.tenon-library a').data(data, @$link.data(data))

  _setToInsertRelative: =>
    method = if @$link.hasClass('below') then 'after' else 'before'
    $('.tenon-library a').data('association-insertion-node', @$link.closest('.tn-tc-row'))
    $('.tenon-library a').data('association-insertion-method', method)