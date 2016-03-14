class Tenon.features.ModalWindows
  @closeModals: ->
    @clearBody()
    $('.modal:not([data-reactid]').removeClass('modal--is-active')

  @clearBody: ->
    $('.modal-overlay:not([data-reactid]').removeClass('modal-overlay--is-active')
    $('body').css(overflow: '')

  @prepBodyForModal: ->
    $overlay = $('<div class="modal-overlay" />')
    $overlay.appendTo('body') unless $('.modal-overlay').length
    $('body').css(overflow: 'hidden')
    setTimeout( ->
      $overlay.addClass('modal-overlay--is-active')
    , 0
    )

  constructor: ->
    tags = [
      '[data-modal-target]',
      '[data-modal-remote]',
      '[data-model-content]',
      '[data-keyboard]'
    ]
    $(document).on('click', tags.join(', '), @launchFromLink)
    $(document).on('click', '.modal-overlay, [data-modal-close]', @closeModals)
    $('body').on('keyup', (e) => @closeModals() if e.which == 27)
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

  closeModals: ->
    Tenon.features.ModalWindows.closeModals()

  _chooseStrategy: =>
    @_launchWithUrl() if @opts.remote
    @_launchWithTarget() if @opts.target?.length
    @_launchWithContent() if @opts.content?.length

  _launchWithUrl: (e) =>
    @remote = true
    Tenon.$genericLoader.show()
    $.ajax
      url: @opts.href
      dataType: 'html'
      success: @_openInModal
      beforeSend: null

  _launchWithTarget: (e) =>
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
    @$modalElement = @_getModalElement()
    @_drawAndDisplayModal()
    @_runShownHandler()

  _getModalElement: =>
    if @_isBodyProvided()
      @$el
    else
      $(@_setupTemplate())

  _setupTemplate: =>
    $template = $(JST['tenon/templates/modal']())
    $template.find('.modal__content').append(@$el)
    console.log($template.html())
    $template


  _isBodyProvided: =>
    @$el.find('.modal__content').length > 0

  _drawAndDisplayModal: =>
    @$modalElement.appendTo('body')
    Tenon.features.ModalWindows.prepBodyForModal()
    setTimeout( =>
      @$modalElement.addClass('modal--is-active')
    , 0)

  _runShownHandler: =>
    if @opts.handler?.length
      parts = @opts.handler.split('.')
      method = window
      $(parts).each (i, part) -> method = method[part]
      new method(@opts.$link, @$el, @$modalElement)

    # Default shown action
    @_focusFirstField()

  _focusFirstField: ->
    selectors = [
      ".modal-content form input[type!='hidden']",
      ".modal-content form select",
      ".modal-content form textarea"
    ]
    el = $(selectors.join(', '))[0]
    $(el).focus()
