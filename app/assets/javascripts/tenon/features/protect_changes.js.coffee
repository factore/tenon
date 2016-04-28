class Tenon.features.ProtectChanges
  constructor: ->
    @changesMade = false
    @bindChangeEvents()
    $(window).on('beforeunload', @confirmNavigation)

  bindChangeEvents: =>
    @$form = $('.main-content form')
    @$form.on('cocoon:after-insert cocoon:after-remove', @_markChanged)
    @$form.on('keyup change', 'input, select, textarea', @_markChanged)
    @$form.on('input', '.editable-text', @_markChanged)
    @$form.on('submit', @_clearChanges)

  _markChanged: (e) =>
    ignore = [37, 38, 39, 40, 20, 16, 17, 18]
    code = e.keyCode || e.which
    @changesMade = true if $.inArray(code, ignore) == -1

  _clearChanges: =>
    @changesMade = false
    return true

  confirmNavigation: =>
    if @changesMade
      I18n.tenon.common.you_have_unsaved_changes
