class Tenon.features.RecordDeletion
  constructor: ->
    selector = 'a[data-method="Delete"], a[data-method="delete"]'
    $('.record-list').on('ajax:beforeSend', selector, @_showSpinner)
    $('.record-list').on('ajax:success', selector, @_handleSuccess)

  _showSpinner: (e) =>
    $link = $(e.currentTarget)
    $link.find('i')
         .removeClass('fa fa-trash-o')
         .addClass('fa fa-spinner fa fa-spin')

  _handleSuccess: (e, data) =>
    @$link = $(e.currentTarget)
    if data && data.errors && data.errors.base
      @_handleError(data.errors.base)
    else
      @$link.closest('li').fadeOut(-> $(@).remove())

  _handleError: (error) =>
    new Tenon.features.Alert('error', error)
    @$link.find('i')
          .removeClass('fa fa-spinner fa fa-spin')
          .addClass('fa fa-trash-o')
