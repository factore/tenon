class Tenon.features.ModalWindows
  constructor: ->
    tags = '[data-modal-target], [data-modal-remote], [data-model-content], [data-keyboard]'
    $(document).on('click', tags, @setupAndLaunch)

  setupAndLaunch: (e) =>
    e.preventDefault()
    @$link = $(e.currentTarget)
    @_chooseStrategy()

  _chooseStrategy: =>
    @_launchWithUrl() if @$link.data('modal-remote')
    @_launchWithTarget() if @$link.data('modal-target')
    @_launchWithContent() if @$link.data('modal-content')

  _launchWithUrl: (e) =>
    @remote = true
    Tenon.$genericLoader.show()
    $.ajax
      url: @$link.attr('href')
      dataType: 'html'
      success: @_openInModal
      beforeSend: null

  _launchWithTarget: (e) =>
    if @$link.data('modal-closest')
      $parentNode = @$link.closest(@$link.data('modal-closest'))
      $el = $parentNode.find(@$link.data('modal-target'))
    else if @$link.data('modal-parent')
      $el = $(@$link.data('modal-parent')).find(@$link.data('modal-target'))
    else
      $el = $(@$link.data('modal-target'))
    $el = $el.filter(':first').clone() if @$link.data('modal-clone')

    @_openInModal($el)

  _openInModal: (el) =>
    Tenon.$genericLoader.hide()
    @$el = $(el)
    @$template = $(@_setupTemplate())
    @_appendContent()
    @$el.show()
    @modal = @$template.modal(keyboard: @$link.data('keyboard'))
    @modal
      .on('shown.bs.modal', @_runShownHandler)
      .on('hidden.bs.modal', @_runHiddenHandler)

  _setupTemplate: =>
    JST['tenon/templates/modal']
      title: @$link.data('modal-title'),
      bodyProvided: @_bodyProvided()

  _bodyProvided: =>
    return @__bodyProvided if @__bodyProvided
    @__bodyProvided = @$el.find('.modal-body').length > 0

  _appendContent: =>
    target = if @_bodyProvided() then '.modal-content' else '.modal-body'
    @$template.find(target).append(@$el)


  _runShownHandler: =>
    if @$link.data('modal-handler')
      parts = @$link.data('modal-handler').split('.')
      method = window
      $(parts).each (i, part) -> method = method[part]
      new method(@$link, @$el, @$template)

    # Default shown action
    $('select').select2()

    @_focusFirstField()

  _runHiddenHandler: =>
    @$template.remove() if @remote

  _focusFirstField: =>
    el = $(".modal-content form input[type!='hidden'], .modal-content form select, .modal-content form textarea")[0]
    $(el).focus()
