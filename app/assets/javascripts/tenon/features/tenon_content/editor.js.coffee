class Tenon.features.tenonContent.Editor
  constructor: ->
    $(document).on('cocoon:after-insert', '.tenon-content', @_rowInserted)
    $(document).on('cocoon:after-remove', '.tenon-content', @_rowRemoved)
    $(document).on('input keypress paste change', '.editable-text', @_contentUpdated)
    for div in $('.tn-tc')
      @_updateButtons($(div))

    CKEDITOR.on 'instanceReady', ->
      Tenon.features.Editor.watchChanges()

  _rowInserted: (e) =>
    # Reactivate Editor
    $wrap = $(e.currentTarget).closest('.tn-tc')
    @_redrawCkeditor()
    @_updateButtons($wrap)

  _rowRemoved: (e) =>
    @_updateButtons($(e.currentTarget).closest('.tn-tc'))

  _contentUpdated: (e) =>
    $editable = $(e.currentTarget)
    $editable.next('input[type=hidden]').val($editable.html())

  _updateButtons: ($wrap)=>
    if $wrap.find('.tn-tc-row:visible').length == 0
      $wrap.find('.tn-tc-add-content').show()
      $wrap.find('.tn-tc-pop-out').hide()
    else
      $wrap.find('.tn-tc-add-content').hide()
      $wrap.find('.tn-tc-pop-out').show()

  _redrawCkeditor: =>
    Tenon.features.Editor.reinitInline()
