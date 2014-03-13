class Tenon.features.RecordTypeSelector
  constructor: ->
    @$list = $('[data-records-url]')
    $('.sidebar nav').on('click', '[data-type]', @_selectRecords)

  _selectRecords: (e) =>
    @$link = $(e.currentTarget)
    @_setParams()
    @_clearList()
    @_loadRecords()
    @_setActive()

  _setParams: =>
    params = @$list.data('records-params') || {}
    params.type = @$link.data('type')
    @$list.data('records-params', params)
    @$list.data('records-page', 1)

  _clearList: =>
    @$list.find('li').remove()

  _loadRecords: =>
    new Tenon.features.RecordList(@$list)

  _setActive: =>
    @$link.closest('li')
      .addClass('active')
      .siblings().removeClass('active')