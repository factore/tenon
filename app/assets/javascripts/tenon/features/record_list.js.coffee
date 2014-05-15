class Tenon.features.RecordList
  constructor: (@$list, @opts = {}) ->
    @openClass = 'open'
    Tenon.activeRecordList = this
    @refresh()

  refresh: (opts = {}) =>
    @opts = $.extend(@opts, opts)
    @_clearRecords() if @opts.clear
    @_setupTemplate()
    @_setupPagination()
    @_updateParams()
    @_showLoader()
    @_loadRecords()


  _setupTemplate: =>
    @_templatePath = @$list.data('records-template')
    @_recordName = @$list.data('records-name')
    @_templateOpts = {}

  _setupPagination: =>
    @$list.data('records-page', 1) unless @$list.data('records-page')?
    @_currentPage = @$list.data('records-page')

  _clearRecords: =>
    @$list.find('li:not(.header)').remove()
    @$list.data('records-page', 1)

  _updateParams: =>
    @params = URI(window.location).query(true)
    @params = $.extend(@params, @$list.data('records-params'))
    @params = $.extend(@params, @opts.params)

  _loadRecords: (i, list) =>
    data = {page: @_currentPage}
    data = $.extend(data, @params)
    $.getJSON(@$list.data('records-url'), data)
      .done(@_dataLoaded)
      .fail(@_failedLoad)
      .always(@_hideLoader)

  _dataLoaded: (data) =>
    if data.records.length == 0
      @_showInfoLi('No entries found.')
    else if @$list.data('records-nested')
      @_showInfoLi('No entries found.') if data.records.length == 0
      new Tenon.features.NestedSetWriter(data.records, @$list, @_templatePath, @_recordName)
    else
      @_drawRecords(data.records)
      @_toggleInfiniteLoader(data.pagination)
    $('.sortable').tenonTwoLevelSort()
    @$list.trigger('tenon.records-refreshed')

  _failedLoad: =>
    @_showInfoLi('There was an error contacting the server.')

  _drawRecords: (records) =>
    for record in records
      @_templateOpts[@_recordName] = record
      @$list.append(JST[@_templatePath](@_templateOpts))
    @$list.imagesLoaded => @$list.find('li.hidden').removeClass('hidden')

  _showInfoLi: (msg) =>
    $divs = [
      $('<div />').addClass('record-title').html(msg)
    ]
    $details = $('<div />').addClass('record-details').html($divs)
    $('<li />').addClass('info').html($details).appendTo(@$list)

  _toggleInfiniteLoader: (pagination) =>
    $loader = $(".infinite-loader[data-record-list='##{@$list.attr('id')}']")
    if @_currentPage < parseInt(pagination.totalPages)
      $loader.addClass(@openClass)
    else
      $loader.removeClass(@openClass)

  _showLoader: =>
    i = $('<i />').addClass('fa fa-gear fa fa-4x fa fa-spin')
    div = $('<div />').append(i)
    li = $('<li />')
      .addClass('loader')
      .append(div)
      .appendTo(@$list)

  _hideLoader: =>
    @$list.find('li.loader').remove()
