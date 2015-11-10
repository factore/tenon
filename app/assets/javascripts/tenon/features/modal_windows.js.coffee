class Tenon.features.ModalWindows
  constructor: ->
    tags = '[data-modal-target], [data-modal-remote], [data-model-content], [data-keyboard]'
    $(document).on('click', tags, @launchFromLink)

  # Opts:
  #   $link: if launched by data tags, the link that was clicked
  #   title: string -- Title for the modal window
  #   remote: bool -- launch via a URL?
  #   href: string -- remote URL to launch
  #   target: string -- selector for the HTML element
  #   parent: string -- selector to use for parent of target
  #   handler: string -- string version of the class to instantiate on opening
  #   closest: string -- selector for link's parent when finding target
  #   clone: bool -- clone the target before putting it in the modal?
  #   content: string -- content to output directly in the modal
  #   keyboard: boolean -- legacy, not sure what it does
  launchWithOpts: (@opts = {}) =>
    @_chooseStrategy()

  launchFromLink: (e) =>
    e.preventDefault()
    $link = $(e.currentTarget)
    @opts =
      $link: $link
      href: $link.attr('href')
      title: $link.data('modal-title')
      remote: $link.data('modal-remote')
      target: $link.data('modal-target')
      handler: $link.data('modal-handler')
      closest: $link.data('modal-closest')
      parent: $link.data('modal-parent')
      clone: $link.data('modal-clone')
      content: $link.data('modal-content')
      keyboard: $link.data('keyboard')
    @_chooseStrategy()

  _chooseStrategy: =>
    @_launchWithUrl() if @opts.remote
    @_launchWithTarget() if @opts.target?.length
    @_launchWithContent() if @opts.content?.length

  _launchWithUrl: (e) =>
    console.debug("called _launchWithUrl")
    @remote = true
    Tenon.$genericLoader.show()
    $.ajax
      url: @opts.href
      dataType: 'html'
      success: @_openInModal
      beforeSend: null

  _launchWithTarget: (e) =>
    console.debug("called _launchWithTarget")
    if @opts.closest?.length && @opts.$link
      $parentNode = @opts.$link.closest(@opts.closest)
      $el = $parentNode.find(@opts.target)
    else if @opts.parent?.length
      $el = $(@opts.parent).find(@opts.target)
    else
      $el = $(@opts.target)
    $el = $el.filter(':first').clone() if @opts.clone
    @_openInModal($el)

  _openInModal: (el) =>
    Tenon.$genericLoader.hide()
    @$el = $(el)
    @$template = $(@_setupTemplate())
    @_appendContent()
    @$el.show()
    @modal = @$template.modal(keyboard: @opts.keyboard)
    @modal
      .on('shown.bs.modal', @_runShownHandler)
      .on('hidden.bs.modal', @_runHiddenHandler)

  _setupTemplate: =>
    JST['tenon/templates/modal']
      title: @opts.title,
      bodyProvided: @_bodyProvided()

  _bodyProvided: =>
    return @__bodyProvided if @__bodyProvided
    @__bodyProvided = @$el.find('.modal-body').length > 0

  _appendContent: =>
    target = if @_bodyProvided() then '.modal-content' else '.modal-body'
    @$template.find(target).append(@$el)


  _runShownHandler: =>
    if @opts.handler?.length
      parts = @opts.handler.split('.')
      method = window
      $(parts).each (i, part) -> method = method[part]
      new method(@opts.$link, @$el, @$template)

    # Default shown action
    $('select').select2()
    @_focusFirstField()

  _runHiddenHandler: =>
    @$template.remove() if @remote

  _focusFirstField: =>
    el = $(".modal-content form input[type!='hidden'], .modal-content form select, .modal-content form textarea")[0]
    $(el).focus()
