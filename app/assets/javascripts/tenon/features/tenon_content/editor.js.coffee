class Tenon.features.tenonContent.Editor
  constructor: ->
    $('.tenon-content').on('cocoon:after-insert', @_rowInserted)
    $('.tenon-content').on('cocoon:after-remove', @_rowRemoved)
    $(document).on('input keypress paste change', '.editable-text', @_contentUpdated)
    for div in $('.tn-tc')
      @_updateButtons($(div))

  _rowInserted: (e) =>
    Tenon.mediumEditor.deactivate()
    new Tenon.features.Medium
    @_updateButtons($(e.currentTarget).closest('.tn-tc'))

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
