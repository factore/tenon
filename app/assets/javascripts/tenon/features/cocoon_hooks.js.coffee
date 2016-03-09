class Tenon.features.CocoonHooks
  constructor: ->
    $(document).on('cocoon:after-insert', @afterInsert)

  afterInsert: (e, insertedItem) =>
    @$insertedItem = $(insertedItem)
    @_checkTenonContent()
    Tenon.features.Editor.reinitInline()

  _checkTenonContent: ->
    if @$insertedItem.find('.tn-tc')
      new Tenon.features.tenonContent.Base
