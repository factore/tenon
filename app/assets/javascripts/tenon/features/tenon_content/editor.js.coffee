class Tenon.features.tenonContent.Editor
  constructor: ->
    $('.tenon-content').on('cocoon:after-insert', @_rowInserted)
    $('.tenon-content').on('cocoon:after-remove', @_rowRemoved)
    $(document).on('input', '.editable-text', @_contentUpdated)
    @_updateButtons()

  _rowInserted: (e) =>
    Tenon.mediumEditor.deactivate()
    new Tenon.features.Medium
    @_updateButtons()

  _rowRemoved: (e) =>
    @_updateButtons()

  _contentUpdated: (e) =>
    $editable = $(e.currentTarget)
    $editable.next('input[type=hidden]').val($editable.html())

  _updateButtons: =>
    if $('.tn-tc-row:visible').length == 0
      $('#tn-tc-add-content').show()
      $('#tn-tc-pop-out').hide()
    else
      $('#tn-tc-add-content').hide()
      $('#tn-tc-pop-out').show()
