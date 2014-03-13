class Tenon.features.ModalForms
  constructor: ->
    $(document).on('ajax:success', '.modal form[data-remote]', @_handleSuccess)
    $(document).on('ajax:error', '.modal form[data-remote]', @_handleError)

  _handleSuccess: (e, data) =>
    @$form = $(e.currentTarget)
    @record = data
    @$list = $('[data-records-url]')
    @$template = $(@_getTemplate())
    @_writeTemplate()
    @_hideModal()

  _getTemplate: =>
    recordName = @$form.data('record')
    templatePath = "#{_.pluralize(recordName)}/#{recordName}_row"
    opts = {}
    opts[recordName] = @record
    JST["tenon/templates/#{templatePath}"](opts)

  _writeTemplate: =>
    $li = @$list.find("[data-record-id='#{@record.id}']")
    $header = @$list.find("li.header")
    if $li[0]
      @$template.removeClass('hidden')
      $li.replaceWith(@$template)
    else if $header[0]
      $template.insertAfter($header)
    else
      @$list.prepend(@$template)
    @$list.find('li.info').remove()

  _hideModal: =>
    @$form.find('.errorExplanation').remove()
    @$form[0].reset()
    @$form.closest('.modal').modal('hide')

  _handleError: (e, response, status) =>
    @$form = $(e.currentTarget)
    errors = $.parseJSON(response.responseText).errors
    $template = $(JST['tenon/templates/errors'](errors: errors))
    @$form.find('.errorExplanation').remove()
    $template.prependTo('.modal-body')

