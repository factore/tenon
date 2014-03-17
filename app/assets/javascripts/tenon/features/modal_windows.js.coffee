class Tenon.features.ModalWindows
  constructor: ->
    tags = '[data-modal-target], [data-modal-remote], [data-model-content]'
    $(document).on('click', tags, @_setupAndLaunch)

  _setupAndLaunch: (e) =>
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
    if @$link.data('modal-clone')
      $el = $(@$link.data('modal-target') + ':first').clone()
    else
      $el = $(@$link.data('modal-target'))
    @_openInModal($el)

  _openInModal: (el) =>
    Tenon.$genericLoader.hide()
    @$el = $(el)
    @$template = $(@_setupTemplate())
    @_appendContent()
    @$el.show()
    @modal = @$template.modal(keyboard: true)
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

  _runHiddenHandler: =>
    @$template.remove() if @remote
