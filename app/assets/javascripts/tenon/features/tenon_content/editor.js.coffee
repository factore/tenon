class Tenon.features.tenonContent.Editor
  constructor: ->
    $('.tenon-content').on('cocoon:after-insert', @_rowInserted)
    $(document).on('input', '.editable-text', @_contentUpdated)

  _rowInserted: (e) =>
    Tenon.mediumEditor.deactivate()
    Tenon.mediumEditor = new MediumEditor($('.editable-text'), {
      placeholder: '',
      forcePlainText: true,
      cssClasses: {
        placeholder: 'medium-placeholder'
      },
      firstHeader: 'h1',
      secondHeader: 'h2',
      buttons: ['bold', 'italic', 'underline', 'anchor', 'header1', 'header2', 'quote', 'unorderedlist', 'orderedlist']    });

  _contentUpdated: (e) =>
    $editable = $(e.currentTarget)
    $editable.next('input[type=hidden]').val($editable.html())